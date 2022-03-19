import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { baseSchemaBuilder as build } from './utils';

interface IdentityProvider {
  id: number;
  name: string;
  type: string;
  config?: Record<string, unknown>;
  sign_in_source?: string;
  supportedDomains?: string;
  param_val?: Record<string, unknown>;
  has_refresh?: boolean;
  refresh_source?: string;
  domain_whitelist?: string;
  has_sign_up?: boolean;
  sign_up_source?: string;
  has_change_password?: boolean;
  change_password_source?: string;
  has_delete_user?: boolean;
  delete_user_source?: string;
}

export interface ApiFunctions {
  getIdentityProviderByUserId: ApiFunction<{ userId: number }, void, IdentityProvider>;
  getIdentityProviderLocalDatabase: ApiFunction<void, void, IdentityProvider>;
  getAllIdentityProviders: ApiFunction<void, void, IdentityProvider[]>;
  getIdentityProviderById: ApiFunction<{ id: number | string }, void, IdentityProvider>;
  getDefaultIdentityProvider: ApiFunction<void, void, IdentityProvider>;
}

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getIdentityProviderByUserId: build(
    'queryOne',
    "/user?include='ip':identity_provider[id=identity_provider_id]&include='ipt':identity_provider_type[id='ip'.identity_provider_type_id]&select='ip'.id,'ip'.name,'type':'ipt'.name,'config':'ip'.param_val,'ipt'.sign_in_source,'ipt'.has_refresh,'ipt'.refresh_source,'ipt'.has_change_password,'ipt'.change_password_source,'ipt'.has_delete_user,'ipt'.delete_user_source&where=and('ip'.status='ACTIVE',id={userId})",
  ),
  getIdentityProviderLocalDatabase: build(
    'queryOne',
    "/identity_provider?include='ipt':identity_provider_type[id=identity_provider_type_id]&select=id,name,param_val&where='ipt'.name='Local Database'",
  ),
  getAllIdentityProviders: build(
    'queryMany',
    "/identity_provider?include='ipt':identity_provider_type[id=identity_provider_type_id]&select=id,name,domain_whitelist,param_val,'type':'ipt'.name,'supportedDomains':param_val->'supportedDomains','ipt'.has_sign_up,'ipt'.sign_up_source&orderby=2",
  ),
  getIdentityProviderById: build(
    'queryOne',
    "/identity_provider?include='ipt':identity_provider_type[id=identity_provider_type_id]&select=id,name,param_val,'ipt'.has_sign_up,'ipt'.sign_up_source&where=id={id}",
  ),
  getDefaultIdentityProvider: build(
    'queryOne',
    "/identity_provider?include='ipt':identity_provider_type[id=identity_provider_type_id]&select=id,name,param_val,'ipt'.has_sign_up,'ipt'.sign_up_source&where=is_default=true",
  ),
};
