import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { baseSchemaBuilder as build } from './utils';

interface RefreshToken {
  id: number;
  user_id: number;
  token: string;
  expires: Date;
  created_by_ip?: string;
}

export interface ApiFunctions {
  getRefreshTokenByToken: ApiFunction<{ token: string }, void, RefreshToken>;
  insertRefreshToken: ApiFunction<void, Omit<RefreshToken, 'id'>, { token: string }>;
}

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getRefreshTokenByToken: build('queryOne', "/refresh_token?select=id,user_id,token,expires&where=token='{token}'"),
  insertRefreshToken: build('insertOne', '/refresh_token?returning=rows(token)'),
};
