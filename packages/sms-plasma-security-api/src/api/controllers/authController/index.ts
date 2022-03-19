import { Request, Response, ErrorHandler } from '@sms/plasma-nodejs-api';
import bcrypt from 'bcryptjs';

import { pgApi } from '../../services';
import { moduleManager } from '../../utils';
import { sendVerificationEmail } from '../../utils/email';
import { generateJwtToken, generateRefreshToken } from '../../utils/token';
import { LoginReqBody, LoginResBody, ParametersResBody, RefreshSource, SignInSource } from './types';

export const parameters = async (req: Request, res: Response<ParametersResBody>) => {
  // Validates the input parameters
  const { code } = req.query as { code: string };
  if (!code) throw new ErrorHandler(400, 'api.message.applicationCodeRequired');

  // Gets the application parameters
  const { data: application } = await pgApi.getApplicationByCode({ params: { code } });
  if (!application) throw new ErrorHandler(400, 'api.message.noParametersFound');
  const { parameters_value } = application;

  // Gets the identity provider
  const { data: idpLocalDatabase } = await pgApi.getIdentityProviderLocalDatabase();
  if (!idpLocalDatabase) throw new ErrorHandler(500, 'api.message.identityProviderNotFound');

  // Gets password policy
  const { data: passwordPolicy } = await pgApi.getAllPasswordPolicies();

  res.status(200).json({
    isUserDefinedByEmail: !!parameters_value?.isUserDefinedByEmail,
    passwordPolicy,
    parameterValues: idpLocalDatabase.param_val,
  });
};

export const login = async (
  req: Request<Record<string, string>, unknown, LoginReqBody>,
  res: Response<LoginResBody>,
) => {
  const { TOKEN_KEY, REFRESH_TOKEN_KEY, TOKEN_EXPIRES_IN, REFRESH_TOKEN_EXPIRES_IN } = process.env;
  const { application_code } = req.headers;

  // Validates the input parameters
  const { username: pUsername, password: pPassword } = req.body;
  if (!pUsername || !pPassword) throw new ErrorHandler(400, 'api.message.credentialsRequired');
  if (!application_code) throw new ErrorHandler(400, 'api.message.applicationCodeRequired');

  // Gets user by username
  const { data: user } = await pgApi.getUserByUsername({ params: { username: pUsername } });
  if (!user) throw new ErrorHandler(401, 'api.message.userNotFound');
  if (user.status === 'INACTIVE') throw new ErrorHandler(400, 'api.message.accountInactive');
  if (user.status === 'PENDING') {
    // Gets the application parameters
    const { data: application } = await pgApi.getApplicationByCode({ params: { code: application_code as string } });
    if (!application) throw new ErrorHandler(401, 'api.message.noParametersFound');

    try {
      await sendVerificationEmail(user, application);
    } catch {} // eslint-disable-line no-empty
    throw new ErrorHandler(400, 'api.message.pendingEmailConfirmation');
  }
  const { password, ...payload } = user;

  // Gets identity provider by user
  const { data: identityProvider } = await pgApi.getIdentityProviderByUserId({ params: { userId: user.id } });
  if (!identityProvider) throw new ErrorHandler(401, 'api.message.identityProviderNotFound');

  let ok = false;
  let expiresIn = Number(TOKEN_EXPIRES_IN);
  let refreshTokenExpiresIn = Number(REFRESH_TOKEN_EXPIRES_IN);

  if (identityProvider.type === 'Local Database') {
    ok = !!password && bcrypt.compareSync(pPassword, password);
  } else if (!identityProvider.sign_in_source) {
    throw new ErrorHandler(401, 'api.message.noImplementationFoundForIdentityProvider');
  } else {
    const validate = eval(identityProvider.sign_in_source) as SignInSource;

    const tokenKey = identityProvider.name.toLowerCase().replace(/ /g, '_');
    const result = await validate(pUsername, pPassword, identityProvider.config, moduleManager);

    if ((ok = result.ok) && result?.data) {
      const { token, refreshToken } = result.data;

      expiresIn = result.data.tokenExpiresIn;
      refreshTokenExpiresIn = result.data.refreshTokenExpiresIn;

      res.cookie(`@sms/${tokenKey}:token`, token, {
        httpOnly: true,
        expires: new Date(Date.now() + expiresIn * 1000),
      });

      res.cookie(`@sms/${tokenKey}:refreshToken`, refreshToken, {
        httpOnly: true,
        expires: new Date(Date.now() + refreshTokenExpiresIn * 1000),
      });
    }
  }

  if (ok && TOKEN_KEY && REFRESH_TOKEN_KEY) {
    // Generates access token
    const token = await generateJwtToken(payload, expiresIn);

    // Generates refresh token
    const refreshToken = await generateRefreshToken(user.id, req.ip, refreshTokenExpiresIn);

    res
      .cookie(TOKEN_KEY, token, { httpOnly: true })
      .cookie(REFRESH_TOKEN_KEY, refreshToken, { httpOnly: true })
      .setHeader('Authorization', token);
    res.status(200).send();
  } else {
    throw new ErrorHandler(401, 'api.message.passwordsDoesNotMatch');
  }
};

export const refreshToken = async (req: Request, res: Response) => {
  // Validates cookie parameters
  const { TOKEN_KEY = '', REFRESH_TOKEN_KEY = '', TOKEN_EXPIRES_IN = 0 } = process.env;
  if (!req.cookies[REFRESH_TOKEN_KEY]) throw new ErrorHandler(500, 'api.message.invalidToken');

  // Gets user session
  const { data: session } = await pgApi.getRefreshTokenByToken({ params: { token: req.cookies[REFRESH_TOKEN_KEY] } });
  if (!session || Date.now() >= new Date(session.expires).getTime())
    throw new ErrorHandler(500, 'api.message.invalidToken');

  const { data: user } = await pgApi.getUserById({ params: { id: session.user_id } });
  if (!user) throw new ErrorHandler(500, 'api.message.userNotFound');

  // Gets identity provider by user
  const { data: identityProvider } = await pgApi.getIdentityProviderByUserId({ params: { userId: session.user_id } });
  if (!identityProvider) throw new ErrorHandler(500, 'api.message.identityProviderNotFound');

  let expiresIn = Number(TOKEN_EXPIRES_IN);

  // Validates external identity provider refresh token
  if (identityProvider?.has_refresh && identityProvider?.refresh_source && identityProvider.config) {
    const validate = eval(identityProvider.refresh_source) as RefreshSource;

    const tokenKey = identityProvider.name.toLowerCase().replace(/ /g, '_');
    const refreshToken = req.cookies[`@sms/${tokenKey}:refreshToken`];
    const result = await validate(refreshToken, identityProvider.config);

    if (result.ok) {
      const { tokenExpiresIn, token } = result.data;

      res.cookie(`@sms/${tokenKey}:token`, token, {
        httpOnly: true,
        expires: new Date(Date.now() + tokenExpiresIn * 1000),
      });

      expiresIn = tokenExpiresIn;
    } else {
      throw new ErrorHandler(500, 'api.message.invalidToken');
    }
  }

  // Generates new access token
  const token = await generateJwtToken(user, expiresIn);

  res.cookie(TOKEN_KEY, token, { httpOnly: true }).setHeader('Authorization', token);
  res.status(200).send();
};

export const authorize = async (req: Request, res: Response) => {
  const tokenKey = process.env.TOKEN_KEY || '';

  // New token generated by refresh token
  const newToken = res.getHeader('authorization');

  if (!newToken && !req.cookies[tokenKey]) throw new ErrorHandler(500, 'api.message.invalidToken');

  res.setHeader('Authorization', newToken || req.cookies[tokenKey]);
  res.status(200).send();
};
