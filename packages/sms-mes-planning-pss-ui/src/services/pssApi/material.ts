import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { MaterialMovementRequestBody } from '../../types/Material';

export interface ApiFunctions {
  getAvailableMaterialsToAdd: ApiFunction<
    void,
    {
      productionUnitId: string | number;
      sequenceScenarioId: string | number;
      groupSequenceId: string | number;
      materialFilterId?: number;
      planningHorizonId?: number;
    },
    unknown[]
  >;
  moveMaterial: ApiFunction<void, MaterialMovementRequestBody, boolean>;
  deleteMaterial: ApiFunction<
    void,
    { materialId: string | number; sequenceItemId: string | number; sequenceScenarioId: string | number },
    void
  >;
}

const root = '/material';

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getAvailableMaterialsToAdd: {
    method: 'GET',
    path: `${root}/available/add`,
  },
  moveMaterial: {
    method: 'POST',
    path: `${root}/move`,
  },
  deleteMaterial: {
    method: 'POST',
    path: `${root}/remove`,
  },
};
