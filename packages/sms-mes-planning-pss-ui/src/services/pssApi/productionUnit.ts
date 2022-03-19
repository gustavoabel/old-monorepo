import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { ProductionUnitTypes } from '../../types';

export interface ApiFunctions {
  getAllProductionUnit: ApiFunction<void, void, ProductionUnitTypes.ProductionUnit[]>;
  getProductionUnitByGroupId: ApiFunction<
    { productionUnitGroupId: number },
    void,
    ProductionUnitTypes.ProductionUnit[]
  >;
  getCastersByGroupId: ApiFunction<
    { productionUnitGroupId: number; scenarioId: number },
    void,
    ProductionUnitTypes.ProductionUnit[]
  >;
}

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getAllProductionUnit: {
    method: 'GET',
    path: '/productionUnit',
  },
  getProductionUnitByGroupId: {
    method: 'GET',
    path: '/productionUnit/group/{productionUnitGroupId}',
  },
  getCastersByGroupId: {
    method: 'GET',
    path: '/productionUnit/casters/group/{productionUnitGroupId}',
  },
};
