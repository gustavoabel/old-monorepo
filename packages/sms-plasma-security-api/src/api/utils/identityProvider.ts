import { ErrorHandler } from '@sms/plasma-nodejs-api';

import { pgApi } from '../services';
import { Application } from '../services/pgApi/application';

export const getIdentityProviderByEmailDomain = async (email: string, application: Application) => {
  const domain = email.split('@').pop() as string;

  if (application.parameters_value?.deniedDomains?.split(/[\n,]+/).includes(domain))
    throw new ErrorHandler(400, 'api.message.accessDeniedForDomain');

  const { data: identityProviders } = await pgApi.getAllIdentityProviders();
  let identityProvider = identityProviders?.find((idp) => idp.domain_whitelist?.split(/[\n,]+/).includes(domain));

  if (!identityProvider) {
    const { data: idpDefault } = await pgApi.getDefaultIdentityProvider();
    if (!idpDefault) throw new ErrorHandler(500, 'api.message.identityProviderNotFound');

    identityProvider = idpDefault;
  }

  return identityProvider;
};
