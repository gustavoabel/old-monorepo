import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { ProductionUnitGroupTypes } from '../../types';

export interface ApiFunctions {
  getAllProductionUnitGroup: ApiFunction<void, void, ProductionUnitGroupTypes.ProductionUnitGroup[]>;
}

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getAllProductionUnitGroup: {
    method: 'GET',
    path: '/productionUnitGroup',
  },
};
