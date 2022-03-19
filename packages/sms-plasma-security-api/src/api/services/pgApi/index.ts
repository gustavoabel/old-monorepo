import { create, ApiConfig } from '@sms/plasma-api-client';
import { ErrorHandler } from '@sms/plasma-nodejs-api';
import jwt from 'jsonwebtoken';

import * as application from './application';
import * as idetityProvider from './identityProvider';
import * as pwdPolicy from './pwdPolicy';
import * as refreshToken from './refreshToken';
import * as role from './role';
import * as user from './user';

type ApiFunctions = application.ApiFunctions &
  idetityProvider.ApiFunctions &
  user.ApiFunctions &
  role.ApiFunctions &
  pwdPolicy.ApiFunctions &
  refreshToken.ApiFunctions;

const endpoints = {
  ...application.endpoints,
  ...idetityProvider.endpoints,
  ...user.endpoints,
  ...role.endpoints,
  ...pwdPolicy.endpoints,
  ...refreshToken.endpoints,
};

const { PG_API_PROTOCOL, PG_API_PATH } = process.env;

const config: ApiConfig = {
  protocol: PG_API_PROTOCOL as 'HTTP' | 'UDS',
  path: PG_API_PATH,
  prefix: 'api',
  requestTransform: (req) => {
    const { JWT_SECRET, TOKEN_KEY } = process.env;
    if (JWT_SECRET && TOKEN_KEY) {
      const token = jwt.sign({}, JWT_SECRET, { expiresIn: '1m' });
      req.headers['Cookie'] = `${TOKEN_KEY}=${token};`;
    }
  },
  responseTransform: (res) => {
    if (!res.ok) throw new ErrorHandler(res.status, res.data.message);
  },
};

export default create<ApiFunctions>(endpoints, config);
