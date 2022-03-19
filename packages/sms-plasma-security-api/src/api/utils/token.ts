import { ErrorHandler } from '@sms/plasma-nodejs-api';
import crypto from 'crypto';
import jwt from 'jsonwebtoken';
import { groupBy, uniq } from 'lodash';

import { pgApi } from '../services';
import { User } from '../services/pgApi/user';

export const generateJwtToken = async (user: User, expiresIn: number) => {
  const { JWT_SECRET = 'default' } = process.env;

  // Gets user permissions
  const [{ data: roles }, { data: permissions }] = await Promise.all([
    pgApi.getRolesByUserId({ params: { userId: user.id } }),
    pgApi.getPermissionsByUserId({ params: { userId: user.id } }),
  ]);

  const groupedRoles = groupBy(roles, 'application_code');
  const groupedPermissions = groupBy(permissions, 'application_code');
  const security: Record<string, Record<string, unknown>> = {};
  const applicationCodes = uniq([...Object.keys(groupedRoles), ...Object.keys(groupedPermissions)]);

  applicationCodes.forEach((code) => {
    security[code] = {
      is_admin: groupedRoles[code]?.some((role) => role.is_admin) || false,
      roles: groupedRoles[code]?.map((role) => role.name),
      permissions: groupedPermissions[code]?.map((permission) => `${permission.name}:${permission.action}`),
    };
  });

  // Generates access token

  return jwt.sign({ ...user, security }, JWT_SECRET, { expiresIn });
};

export const generateRefreshToken = async (userId: number, ipAddress: string, expiresIn: number) => {
  const { data: refreshToken } = await pgApi.insertRefreshToken({
    data: {
      user_id: userId,
      token: crypto.randomBytes(40).toString('hex'),
      expires: new Date(Date.now() + expiresIn * 1000),
      created_by_ip: ipAddress,
    },
  });

  if (!refreshToken) throw new ErrorHandler(500, 'api.message.invalidToken');

  return refreshToken.token;
};
