import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { baseSchemaBuilder as build } from './utils';

export interface Role {
  id: number;
}

export interface UserRole {
  user_id: number;
  role_id: number;
}

export interface ApiFunctions {
  getAllRolesAassignedByDefault: ApiFunction<void, void, Role[]>;
  insertUserRoles: ApiFunction<void, UserRole[], void>;
}

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getAllRolesAassignedByDefault: build(
    'queryMany',
    "/role?include='a':application[id=application_id]&select=id&where=and('a'.assigned_by_default=true,assigned_by_default=true)",
  ),
  insertUserRoles: build('insertMany', '/user_role'),
};
