import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { LimitConfigurationTypes } from '../../types';

export interface ApiFunctions {
  getAllLimitConfiguration: ApiFunction<void, void, LimitConfigurationTypes.LimitConfiguration[]>;
  updateLimitConfiguration: ApiFunction<void, LimitConfigurationTypes.LimitConfiguration, void>;
}

const root = '/limitConfiguration';

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getAllLimitConfiguration: {
    method: 'GET',
    path: `${root}`,
  },
  updateLimitConfiguration: {
    method: 'PUT',
    path: `${root}`,
  },
};
