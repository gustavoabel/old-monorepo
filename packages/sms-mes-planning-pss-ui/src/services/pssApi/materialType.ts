import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { MaterialTypeTypes } from '../../types';

export interface ApiFunctions {
  getMaterialTypeByProductionUnitId: ApiFunction<{ productionUnitId: number }, void, MaterialTypeTypes.MaterialType[]>;
}

const root = '/materialType';

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getMaterialTypeByProductionUnitId: {
    method: 'GET',
    path: `${root}?productionUnitId={productionUnitId}`,
  },
};
