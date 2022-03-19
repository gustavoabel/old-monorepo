import { createContext } from 'react';

import { GroupSequenceTypes } from '../../types';

type GroupSequenceFormContextType = {
  sequence: GroupSequenceTypes.GroupSequenceFormData;
  setSequence: (sequence: GroupSequenceTypes.GroupSequenceFormData) => void;
};

export const GroupSequenceFormContext = createContext<GroupSequenceFormContextType>({
  sequence: {
    productionUnitGroupId: 0,
    name: '',
    startDate: new Date(),
    scenarioList: [],
  },
  setSequence: () => {
    return;
  },
});
