import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { SequenceScenarioTypes } from '../../types';
import { UnitSequenceMaterialList } from '../../types/UnitSequence';

export interface ApiFunctions {
  getAllSequenceScenarios: ApiFunction<void, void, SequenceScenarioTypes.SequenceScenario[]>;
  getScenariosForSequence: ApiFunction<
    { id: string | number },
    void,
    Partial<SequenceScenarioTypes.SequenceScenario>[]
  >;
  getScenarioMaterialList: ApiFunction<{ sequenceScenarioId: string | number }, void, UnitSequenceMaterialList>;
  createSequenceScenario: ApiFunction<
    void,
    Omit<SequenceScenarioTypes.SequenceScenarioForm, 'id'>,
    SequenceScenarioTypes.SequenceScenarioForm
  >;
  updateSequenceScenario: ApiFunction<
    void,
    Omit<SequenceScenarioTypes.SequenceScenarioForm, 'id'>,
    SequenceScenarioTypes.SequenceScenarioForm
  >;
  deleteSequenceScenario: ApiFunction<{ id: string | number }, void, void>;
}

const root = '/sequenceScenario';

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getAllSequenceScenarios: {
    method: 'GET',
    path: `${root}`,
  },
  getScenariosForSequence: {
    method: 'GET',
    path: `${root}?groupSequenceId={id}`,
  },
  getScenarioMaterialList: {
    method: 'GET',
    path: `${root}/{sequenceScenarioId}/materials`,
  },
  createSequenceScenario: {
    method: 'POST',
    path: `${root}`,
  },
  updateSequenceScenario: {
    method: 'PUT',
    path: `${root}`,
  },
  deleteSequenceScenario: {
    method: 'DELETE',
    path: `${root}/{id}`,
  },
};
