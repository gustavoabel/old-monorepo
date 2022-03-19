import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { GroupSequenceTypes } from '../../types';

export interface ApiFunctions {
  getAllGroupSequence: ApiFunction<void, void, GroupSequenceTypes.GroupSequence[]>;
  createSequence: ApiFunction<
    void,
    Omit<GroupSequenceTypes.GroupSequenceFormData, 'id'>,
    GroupSequenceTypes.GroupSequenceFormData
  >;
  updateSequence: ApiFunction<
    void,
    Omit<GroupSequenceTypes.GroupSequenceFormData, 'id'>,
    GroupSequenceTypes.GroupSequenceFormData
  >;
  deleteSequence: ApiFunction<{ id: string | number }, void, void>;
  bookGroupSequence: ApiFunction<{ groupSequenceId: string | number; sequenceScenarioId: string | number }, void, void>;
  saveToMesSequence: ApiFunction<{ groupSequenceId: string | number }, void, void>;
  getSequenceByScenarioId: ApiFunction<{ scenarioId: string | number }, void, GroupSequenceTypes.GroupSequence>;
}

const root = '/groupSequence';

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getAllGroupSequence: {
    method: 'GET',
    path: `${root}`,
  },
  getSequenceByScenarioId: {
    method: 'GET',
    path: `${root}/getSequenceByScenarioId/{scenarioId}`,
  },
  createSequence: {
    method: 'POST',
    path: `${root}`,
  },
  updateSequence: {
    method: 'PUT',
    path: `${root}`,
  },
  deleteSequence: {
    method: 'DELETE',
    path: `${root}/{id}`,
  },
  bookGroupSequence: {
    method: 'PUT',
    path: `${root}/book/{groupSequenceId}/{sequenceScenarioId}`,
  },
  saveToMesSequence: {
    method: 'POST',
    path: `${root}/saveToMES/{groupSequenceId}`,
  },
};
