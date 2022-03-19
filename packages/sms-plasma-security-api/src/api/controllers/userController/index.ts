import { Request, Response, ErrorHandler } from '@sms/plasma-nodejs-api';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

import forgotPasswordConfig from '../../config/forgotPassword';
import registerConfig from '../../config/register';
import { pgApi } from '../../services';
import { User } from '../../services/pgApi/user';
import { email } from '../../utils';
import { moduleManager } from '../../utils';
import { getIdentityProviderByEmailDomain } from '../../utils/identityProvider';
import { SignInSource } from '../authController/types';
import {
  ChangePasswordReqBody,
  UpdateReqParams as EditReqParams,
  RegisterReqBody,
  RegisterResBody,
  VerifyReqBody,
  ForgotPasswordReqBody,
  ResetPasswordReqBody,
  TokenParams,
  SignUpSource,
  CheckValidLinkResetPasswordReqBody,
  CheckForSignUpReqBody,
  CheckForSignUpResBody,
  ChangePasswordSource,
  DeleteReqParams,
  DeleteUserSource,
  InviteUserReqBody,
  RequestApplicationReqBody,
} from './types';

export const inviteUser = async (req: Request<Record<string, string>, unknown, InviteUserReqBody>, res: Response) => {
  const { domain, usernames } = req.body;
  const { application_code } = req.headers;

  // Validates the input parameters
  if (!domain) throw new ErrorHandler(400, 'api.message.emailDomainRequired');
  if (!usernames || !usernames.length) throw new ErrorHandler(400, 'api.message.usernamesRequired');
  if (!application_code) throw new ErrorHandler(400, 'api.message.applicationCodeRequired');

  // Gets the application parameters
  const { data: application } = await pgApi.getApplicationByCode({ params: { code: application_code as string } });
  if (!application) throw new ErrorHandler(400, 'api.message.noParametersFound');

  // validates whether the domain is allowed
  if (application.parameters_value?.deniedDomains?.split(/[\n,]+/).includes(domain))
    throw new ErrorHandler(400, 'api.message.accessDeniedForDomain');

  // Sends the invitation to the user
  try {
    await email.sendUserInviteEmail(domain, usernames, application);
  } catch {
    throw new ErrorHandler(400, 'api.message.errorSendInvitationEmails');
  }

  res.status(204).send();
};

export const changeUserPassword = async (
  req: Request<EditReqParams, unknown, ChangePasswordReqBody>,
  res: Response,
) => {
  const { id } = req.params;
  const { currentPassword, newPassword } = req.body;

  if (!currentPassword) throw new ErrorHandler(400, 'api.message.currentPasswordRequired');
  if (!newPassword) throw new ErrorHandler(400, 'api.message.newPasswordRequired');

  // Gets the user
  const { data: user } = await pgApi.getUserById({ params: { id } });
  if (!user) throw new ErrorHandler(400, 'api.message.userNotFound');

  // Gets identity provider by user
  const { data: identityProvider } = await pgApi.getIdentityProviderByUserId({ params: { userId: user.id } });
  if (!identityProvider) throw new ErrorHandler(400, 'api.message.identityProviderNotFound');

  // Validates the old password
  if (identityProvider.sign_in_source) {
    const validate = eval(identityProvider.sign_in_source) as SignInSource;
    const { ok } = await validate(user.username, currentPassword, identityProvider.config, moduleManager);
    if (!ok) throw new ErrorHandler(400, 'api.message.wrongPassword');
  } else {
    if (!user.password || !bcrypt.compareSync(currentPassword, user.password))
      throw new ErrorHandler(400, 'api.message.wrongPassword');
  }

  // Updates the user's new password on the external identity provider
  if (identityProvider?.has_change_password && identityProvider?.change_password_source && identityProvider.config) {
    const validate = eval(identityProvider.change_password_source) as ChangePasswordSource;
    const ok = await validate(newPassword, user, identityProvider.config);

    if (!ok) throw new ErrorHandler(400, 'api.message.couldNotUpdatePassword');
  } else {
    // Updates the user with new password
    await pgApi.updateUser({ params: { id }, data: { password: bcrypt.hashSync(newPassword) } });
  }

  res.status(204).send();
};

export const registerUser = async (
  req: Request<Record<string, string>, unknown, RegisterReqBody>,
  res: Response<RegisterResBody>,
) => {
  const { first_name, last_name, email: user_email, username, password, application_code, key } = req.body;

  // Validates the input parameters
  if (!first_name) throw new ErrorHandler(400, 'api.message.firstNameRequired');
  if (!last_name) throw new ErrorHandler(400, 'api.message.lastNameRequired');
  if (!user_email) throw new ErrorHandler(400, 'api.message.businessEmailRequired');
  if (!application_code) throw new ErrorHandler(400, 'api.message.applicationCodeRequired');

  // Validates the invite key
  if (key) {
    try {
      jwt.verify(key, registerConfig.jwt.secret);
    } catch (error) {
      throw new ErrorHandler(400, 'api.message.expiredLink');
    }
  }

  // Gets the application parameters
  const { data: application } = await pgApi.getApplicationByCode({ params: { code: application_code } });
  if (!application) throw new ErrorHandler(400, 'api.message.noParametersFound');
  const { parameters_value } = application;

  if (!parameters_value?.isUserDefinedByEmail && !username) throw new ErrorHandler(400, 'api.message.usernameRequired');
  const { data: registeredUser } = await pgApi.getUserByUsername({ params: { username } });

  if (registeredUser) {
    // Pending user, resends confirmation email
    if (registeredUser.status === 'PENDING') {
      try {
        const user = { id: registeredUser.id, email: user_email };
        await email.sendVerificationEmail(user, application);
      } catch {} // eslint-disable-line no-empty
      throw new ErrorHandler(400, 'api.message.pendingEmailConfirmation');
    }

    throw new ErrorHandler(400, 'api.message.userAlreadyRegistered');
  }

  const { data: registeredEmail } = await pgApi.getUserByEmail({ params: { email: user_email } });
  if (registeredEmail) throw new ErrorHandler(400, 'api.message.emailAddressAlreadyRegistered');

  // Gets the identity provider
  const identityProvider = await getIdentityProviderByEmailDomain(user_email, application);
  if (identityProvider.has_sign_up && !password) throw new ErrorHandler(400, 'api.message.passwordRequired');

  let userData: Omit<User, 'id'> = {
    first_name,
    last_name,
    username,
    email: user_email,
    is_admin: false,
    identity_provider_id: identityProvider.id,
    status: key ? 'ACTIVE' : 'PENDING',
  };

  // Creates user account on external identity provider
  if (identityProvider?.has_sign_up && identityProvider?.sign_up_source && identityProvider.param_val) {
    const validate = eval(identityProvider.sign_up_source) as SignUpSource;
    const ok = await validate({ first_name, last_name, email: user_email, password }, identityProvider.param_val);

    if (!ok) throw new ErrorHandler(400, 'api.message.unableCreateAccount');
  } else if (identityProvider?.has_sign_up) {
    userData = { ...userData, password: bcrypt.hashSync(password) };
  }

  // Inserts the new user
  const { data: insertedUser } = await pgApi.insertUser({ data: userData });
  if (!insertedUser) throw new ErrorHandler(400, 'api.message.unableCreateAccount');

  // Assign default roles
  const { data: rolesToInsert } = await pgApi.getAllRolesAassignedByDefault();
  if (rolesToInsert && rolesToInsert.length) {
    const newUserRoles = rolesToInsert.map((role) => ({ user_id: insertedUser.id, role_id: role.id }));
    await pgApi.insertUserRoles({ data: newUserRoles });
  }

  // Sends confimation e-mail to the user
  try {
    const user = { id: insertedUser.id, email: user_email };
    if (!key) await email.sendVerificationEmail(user, application);
  } catch {
    if (insertedUser) {
      if (identityProvider?.has_delete_user && identityProvider?.delete_user_source && identityProvider.config) {
        const validate = eval(identityProvider.delete_user_source) as DeleteUserSource;
        await validate(insertedUser, identityProvider.config);
      }
      await pgApi.deleteUser({ params: { id: insertedUser.id } });
    }
    throw new ErrorHandler(400, 'api.message.errorSendConfirmationEmail');
  }

  res.status(201).json({ id: insertedUser.id });
};

export const verifyUser = async (req: Request<Record<string, string>, unknown, VerifyReqBody>, res: Response) => {
  const { key } = req.body;

  if (!key) throw new ErrorHandler(400, 'api.message.keyRequired');
  let params: TokenParams;

  // Validates the token key
  try {
    params = jwt.verify(key, registerConfig.jwt.secret) as TokenParams;
  } catch (error) {
    throw new ErrorHandler(400, 'api.message.invalidKey');
  }

  if (params?.id) {
    const { data: user } = await pgApi.getUserById({ params });
    if (!user) throw new ErrorHandler(400, 'api.message.userNotFound');

    // Active user
    await pgApi.updateUser({ params: { id: user.id }, data: { status: 'ACTIVE' } });
  }

  res.status(204).send();
};

export const forgotPassword = async (
  req: Request<Record<string, string>, unknown, ForgotPasswordReqBody>,
  res: Response,
) => {
  const { email: user_email, application_code } = req.body;

  // Validates the input parameters
  if (!user_email) throw new ErrorHandler(400, 'api.message.businessEmailRequired');
  if (!application_code) throw new ErrorHandler(400, 'api.message.applicationCodeRequired');

  // Gets the application parameters
  const { data: application } = await pgApi.getApplicationByCode({ params: { code: application_code } });
  if (!application) throw new ErrorHandler(400, 'api.message.noParametersFound');

  // Gets the user
  const { data: user } = await pgApi.getUserByEmail({ params: { email: user_email } });
  if (!user) throw new ErrorHandler(400, 'api.message.noUserRegisteredEmail');

  if (user.status === 'PENDING') {
    throw new ErrorHandler(400, 'api.message.pendingEmailConfirmation');
  }
  if (user.status === 'INACTIVE') throw new ErrorHandler(400, 'api.message.accountInactive');

  // Gets identity provider by user
  const { data: identityProvider } = await pgApi.getIdentityProviderByUserId({ params: { userId: user.id } });
  if (!identityProvider) throw new ErrorHandler(401, 'Identity provider not found');
  if (!identityProvider?.has_change_password) throw new ErrorHandler(400, 'api.message.unableResetPassword');

  // Sends reset password e-mail to the user
  try {
    await email.sendResetPasswordEmail(user, application);
  } catch {
    throw new ErrorHandler(400, 'api.message.errorSendResetPasswordEmail');
  }

  res.status(204).send();
};

export const checkValidLinkResetPassword = async (
  req: Request<Record<string, string>, unknown, CheckValidLinkResetPasswordReqBody>,
  res: Response,
) => {
  // Validates the token key
  try {
    jwt.verify(req.body?.key, forgotPasswordConfig.jwt.secret);
  } catch (error) {
    throw new ErrorHandler(400, 'api.message.expiredLink');
  }
  res.status(204).send();
};

export const resetPassword = async (
  req: Request<Record<string, string>, unknown, ResetPasswordReqBody>,
  res: Response,
) => {
  const { password: newPassword, key } = req.body;

  // Validates the input parameters
  if (!newPassword) throw new ErrorHandler(400, 'api.message.newPasswordRequired');
  if (!key) throw new ErrorHandler(400, 'api.message.keyRequired');

  // Validates the token key
  let params: TokenParams;
  try {
    params = jwt.verify(key, forgotPasswordConfig.jwt.secret) as TokenParams;
  } catch {
    throw new ErrorHandler(400, 'api.message.expiredLink');
  }
  if (!params?.id) throw new ErrorHandler(400, 'api.message.invalidKey');

  // Gets the user
  const { data: user } = await pgApi.getUserById({ params });
  if (!user) throw new ErrorHandler(400, 'api.message.userNotFound');

  // Gets identity provider by user
  const { data: identityProvider } = await pgApi.getIdentityProviderByUserId({ params: { userId: user.id } });
  if (!identityProvider) throw new ErrorHandler(401, 'api.message.identityProviderNotFound');
  if (!identityProvider?.has_change_password) throw new ErrorHandler(400, 'api.message.unableResetPassword');

  // Updates the user's new password on the external identity provider
  if (identityProvider?.change_password_source && identityProvider.config) {
    const validate = eval(identityProvider.change_password_source) as ChangePasswordSource;
    const ok = await validate(newPassword, user, identityProvider.config);

    if (!ok) throw new ErrorHandler(400, 'api.message.couldNotUpdatePassword');
  } else {
    // Updates the user with new password
    await pgApi.updateUser({ params, data: { password: bcrypt.hashSync(newPassword) } });
  }

  res.status(204).send();
};

export const checkForSignUp = async (
  req: Request<Record<string, string>, unknown, CheckForSignUpReqBody>,
  res: Response<CheckForSignUpResBody>,
) => {
  const { email, application_code } = req.body;
  if (!email) throw new ErrorHandler(400, 'api.message.businessEmailRequired');
  if (!application_code) throw new ErrorHandler(400, 'api.message.applicationCodeRequired');

  // Gets the application parameters
  const { data: application } = await pgApi.getApplicationByCode({ params: { code: application_code } });
  if (!application) throw new ErrorHandler(400, 'api.message.noParametersFound');

  // Gets the identity provider
  const identityProvider = await getIdentityProviderByEmailDomain(email, application);

  res.status(200).json({ hasSignUp: !!identityProvider.has_sign_up });
};

export const deleteUser = async (req: Request<DeleteReqParams, unknown, ChangePasswordReqBody>, res: Response) => {
  const { id } = req.params;

  // Gets the user
  const { data: user } = await pgApi.getUserById({ params: { id } });
  if (!user) throw new ErrorHandler(400, 'api.message.userNotFound');

  // Gets identity provider by user
  const { data: identityProvider } = await pgApi.getIdentityProviderByUserId({ params: { userId: user.id } });
  if (!identityProvider) throw new ErrorHandler(401, 'api.message.identityProviderNotFound');

  // Deletes the user in the external identity provider
  if (identityProvider?.has_delete_user && identityProvider?.delete_user_source && identityProvider.config) {
    const validate = eval(identityProvider.delete_user_source) as DeleteUserSource;
    const ok = await validate(user, identityProvider.config);

    if (!ok) throw new ErrorHandler(400, 'api.message.couldNotDeleteUser');
  }

  // Delete user
  await pgApi.deleteUserContacts({ params: { userId: id } });
  const { ok: deleted } = await pgApi.deleteUser({ params: { id } });
  if (!deleted) throw new ErrorHandler(400, 'api.message.couldNotDeleteUser');

  res.status(204).send();
};

export const requestApplication = async (
  req: Request<DeleteReqParams, unknown, RequestApplicationReqBody>,
  res: Response,
) => {
  const { application_id, user_id } = req.body;
  const { application_code } = req.headers;

  // Validates the input parameters
  if (!application_id) throw new ErrorHandler(400, 'api.message.applicationRequired');
  if (!user_id) throw new ErrorHandler(400, 'api.message.userRequired');
  if (!application_code) throw new ErrorHandler(400, 'api.message.applicationCodeRequired');

  // Gets the application parameters
  const { data: application } = await pgApi.getApplicationByCode({ params: { code: application_code as string } });
  if (!application) throw new ErrorHandler(400, 'api.message.noParametersFound');

  // Gets the user
  const { data: user } = await pgApi.getUserById({ params: { id: user_id } });
  if (!user) throw new ErrorHandler(400, 'api.message.userNotFound');

  const { data: owners } = await pgApi.getUsersOwnerTheApplication({ params: { application_id } });
  if (!owners || !owners.length) throw new ErrorHandler(400, 'api.message.ownerNotFound');

  // Sends the request application to the owners
  try {
    await email.sendApplicationRequestEmail(user, owners, application);
  } catch {
    throw new ErrorHandler(400, 'api.message.errorSendRequestEmails');
  }

  res.status(204).send();
};
