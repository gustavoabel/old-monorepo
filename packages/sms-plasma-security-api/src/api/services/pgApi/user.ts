import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { baseSchemaBuilder as build } from './utils';

export interface User {
  id: number;
  username: string;
  password?: string;
  first_name?: string;
  last_name?: string;
  email: string;
  timezone?: string;
  is_admin: boolean;
  identity_provider_id: number;
  status?: string;
  application_name?: string;
}

interface UserContact {
  user_id: number;
  type: string;
  value: string;
}

interface Permission {
  application_code: number;
  name: string;
  action: string;
}

interface Role {
  application_code: number;
  name: string;
  is_admin: boolean;
}

export interface ApiFunctions {
  getUserById: ApiFunction<{ id: number | string }, void, User>;
  getUserByUsername: ApiFunction<{ username: string }, void, User>;
  getUserByEmail: ApiFunction<{ email: string }, void, User>;
  getRolesByUserId: ApiFunction<{ userId: number }, void, Role[]>;
  getPermissionsByUserId: ApiFunction<{ userId: number }, void, Permission[]>;
  insertUser: ApiFunction<void, Omit<User, 'id'>, { id: number }>;
  insertUserContacts: ApiFunction<void, UserContact[], void>;
  updateUser: ApiFunction<{ id: number | string }, Partial<User>, void>;
  deleteUser: ApiFunction<{ id: number | string }, void, void>;
  deleteUserContacts: ApiFunction<{ userId: number | string }, void, void>;
  getUsersOwnerTheApplication: ApiFunction<{ application_id: number }, void, User[]>;
}

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getUserById: build('queryOne', '/user?select=id,username,password,first_name,last_name,is_admin,email&where=id={id}'),
  getUserByUsername: build(
    'queryOne',
    "/user?select=id,username,password,first_name,last_name,is_admin,email,status&where=and(isnull(deleted_at),username='{username}')",
  ),
  getUserByEmail: build(
    'queryOne',
    "/user?select=id,username,password,first_name,last_name,is_admin,email,status&where=and(isnull(deleted_at),email='{email}')",
  ),
  getRolesByUserId: build(
    'queryMany',
    "/user_role?include='r':role[id=role_id]&include='a':application[id='r'.application_id]&select=distinct('application_code':'a'.code,'r'.name,'r'.is_admin)&where=and(user_id={userId},isnull('r'.deleted_at),'r'.status='ACTIVE')&orderby=1,2,3",
  ),
  getPermissionsByUserId: build(
    'queryMany',
    "/user_permission?include='a':application[id=application_id]&select='application_code':'a'.code,'name':resource,action&where=user_id={userId}&orderby=1,2,3",
  ),
  insertUser: build('insertOne', '/user?returning=rows(id)'),
  insertUserContacts: build('insertMany', '/contact_info'),
  updateUser: build('updateOne', '/user?where=id={id}'),
  deleteUser: build('delete', '/user?where=id={id}'),
  deleteUserContacts: build('delete', '/contact_info?where=user_id={userId}'),
  getUsersOwnerTheApplication: build(
    'queryMany',
    "/user?include='ur':user_role[user_id=id]&include='r':role[id='ur'.role_id]&include='a':application[id='r'.application_id]&select=distinct(id,username,password,first_name,last_name,is_admin,email,'application_name':'a'.name)&where=and(isnull(deleted_at),'a'.id={application_id},is_admin=true)&orderby=2",
  ),
};
