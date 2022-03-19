import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { UnitSequenceTypes } from '../../types';

export interface ApiFunctions {
  getByScenario: ApiFunction<void, { sequenceScenarioId: number | string }, UnitSequenceTypes.UnitSequence[]>;
  getCasterByScenario: ApiFunction<void, { scenarioId: number | string }, UnitSequenceTypes.UnitSequence[]>;
  getHeatListByUnitSequence: ApiFunction<void, { unitSequenceId: number }, UnitSequenceTypes.UnitSequenceHeat[]>;
  getNewOutputOrder: ApiFunction<void, { sequenceItemId: number }, number>;
  addNewMaterial: ApiFunction<
    void,
    { unitSequenceId: string | number; sequenceItemId?: string | number; materialId: number; materialOrder?: number }[],
    void
  >;
  getSumByUnitSequence: ApiFunction<
    { unitName: string | number; scenarioId: string | number },
    void,
    UnitSequenceTypes.UnitSequenceSum
  >;
}

const root = '/unitSequence';

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getByScenario: {
    method: 'GET',
    path: `${root}`,
  },
  getCasterByScenario: {
    method: 'GET',
    path: `${root}/casters`,
  },
  getHeatListByUnitSequence: {
    method: 'GET',
    path: `${root}/heats`,
  },
  getNewOutputOrder: {
    method: 'GET',
    path: `${root}/output/order`,
  },
  addNewMaterial: {
    method: 'POST',
    path: `${root}/material`,
  },
  getSumByUnitSequence: {
    method: 'GET',
    path: `${root}/{unitName}/{scenarioId}/sum`,
  },
};
