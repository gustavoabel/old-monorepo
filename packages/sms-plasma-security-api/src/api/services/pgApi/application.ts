import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { baseSchemaBuilder as build } from './utils';

export interface Application {
  id: number;
  name: string;
  code: string;
  parameters_value?: ApplicationParameters;
}

export interface ApplicationParameters {
  emailHost: string;
  emailPort: number;
  emailUsername: string;
  emailPassword: string;
  isUserDefinedByEmail?: boolean;
  deniedDomains?: string;
}

export interface ApiFunctions {
  getApplicationByCode: ApiFunction<{ code: string }, void, Application>;
}

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getApplicationByCode: build('queryOne', "/application?select=id,name,code,parameters_value&where=code='{code}'"),
};
