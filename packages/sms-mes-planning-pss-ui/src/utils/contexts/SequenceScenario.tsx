/* eslint-disable @typescript-eslint/no-unused-vars */
import React, { createContext } from 'react';

import { DynamicObject } from '../../types/DynamicObject';
import { GroupSequence } from '../../types/GroupSequence';
import { SequenceScenario } from '../../types/SequenceScenario';

type SequenceScenarioContextType = {
  selectedSequence: GroupSequence | null;
  selectedScenario: SequenceScenario | null | Partial<SequenceScenario>;
  selectedMaterial: never | null;
  setSelectedSequence: React.Dispatch<React.SetStateAction<GroupSequence | null>>;
  setSelectedScenario: React.Dispatch<React.SetStateAction<SequenceScenario | null | Partial<SequenceScenario>>>;
  setSelectedMaterial: React.Dispatch<React.SetStateAction<null>>;
  searchScenarioBySequence: (value: number) => void;
  refetchGroupSequenceList?: () => void;
  handleGroupSequence?: (value: string | number) => void;
};

export const SequenceScenarioContext = createContext<SequenceScenarioContextType>({
  selectedSequence: null,
  selectedScenario: null,
  selectedMaterial: null,
  setSelectedSequence: (value) => {
    return;
  },
  setSelectedScenario: (value) => {
    return;
  },
  setSelectedMaterial: (value) => {
    return;
  },
  searchScenarioBySequence: (value: number) => {
    return;
  },
  refetchGroupSequenceList: () => {
    return;
  },
  handleGroupSequence: (value: string | number) => {
    return;
  },
});
