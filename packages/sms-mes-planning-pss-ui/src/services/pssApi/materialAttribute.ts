import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { MaterialAttributeTypes } from '../../types';

export interface ApiFunctions {
  getMaterialAttributeByUnitGroup: ApiFunction<
    { productionUnitGroupId: number },
    void,
    MaterialAttributeTypes.MaterialAttribute[]
  >;
  getMaterialFilterOptions: ApiFunction<
    { productionUnitGroupId: number },
    void,
    MaterialAttributeTypes.MaterialAttribute[]
  >;
  getSchedulingRulesOptions: ApiFunction<{ materialTypeId: number }, void, MaterialAttributeTypes.MaterialAttribute[]>;
  getAddMaterialAttributes: ApiFunction<{ productionUnitId: number }, void, MaterialAttributeTypes.MaterialAttribute[]>;
  setCustomColumnOrder: ApiFunction<void, { tableType: string; userId: string; columnOrder: string }, string>;
  getCustomColumnOrder: ApiFunction<{ tableType: string; userId: string }, void, string>;
}

const root = '/materialAttributeDefinition';

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getMaterialAttributeByUnitGroup: {
    method: 'GET',
    path: `${root}/planningHorizonOptions/{productionUnitGroupId}`,
  },
  getMaterialFilterOptions: {
    method: 'GET',
    path: `${root}/materialFilterOptions/{productionUnitGroupId}`,
  },
  getSchedulingRulesOptions: {
    method: 'GET',
    path: `${root}/schedulingRulesOptions/{materialTypeId}`,
  },
  getAddMaterialAttributes: {
    method: 'GET',
    path: `${root}/addMaterialAttributes/{productionUnitId}`,
  },
  setCustomColumnOrder: {
    method: 'POST',
    path: `${root}/customColumnOrder`,
  },
  getCustomColumnOrder: {
    method: 'GET',
    path: `${root}/customColumnOrder/{tableType}/{userId}`,
  },
};
