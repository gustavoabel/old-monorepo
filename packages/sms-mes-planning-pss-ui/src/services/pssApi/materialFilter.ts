import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { MaterialFilterTypes } from '../../types';

export interface ApiFunctions {
  getAllMaterialFilter: ApiFunction<void, void, MaterialFilterTypes.MaterialFilter[]>;
  getComboMaterialFilter: ApiFunction<
    { id: number },
    void,
    Omit<
      MaterialFilterTypes.MaterialFilter,
      'productionUnitGroupId' | 'description' | 'expression' | 'logic' | 'isDefault'
    >[]
  >;
  createMaterialFilter: ApiFunction<void, Omit<MaterialFilterTypes.MaterialFilter, 'id'>, void>;
  updateMaterialFilter: ApiFunction<void, MaterialFilterTypes.MaterialFilter, void>;
  deleteMaterialFilter: ApiFunction<{ id: string | number }, void, void>;
}

const root = '/materialFilter';

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getAllMaterialFilter: {
    method: 'GET',
    path: `${root}`,
  },
  getComboMaterialFilter: {
    method: 'GET',
    path: `${root}/{id}`,
  },
  createMaterialFilter: {
    method: 'POST',
    path: `${root}`,
  },
  updateMaterialFilter: {
    method: 'PUT',
    path: `${root}`,
  },
  deleteMaterialFilter: {
    method: 'DELETE',
    path: `${root}/{id}`,
  },
};
