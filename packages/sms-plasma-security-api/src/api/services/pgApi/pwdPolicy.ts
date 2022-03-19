import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { baseSchemaBuilder as build } from './utils';

export interface PasswordPolicy {
  id: number;
  name: string;
  source: string;
}

export interface ApiFunctions {
  getAllPasswordPolicies: ApiFunction<void, void, PasswordPolicy[]>;
}

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getAllPasswordPolicies: build('queryMany', "/pwd_policy?select=id,name,source&where=status='ACTIVE'"),
};
