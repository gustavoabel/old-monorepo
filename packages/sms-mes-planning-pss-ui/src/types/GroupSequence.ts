import { Modify } from '..';

import { SequenceScenarioForm } from './SequenceScenario';

export interface GroupSequence {
  id: number;
  name: string;
  startDate: Date;
  remark: string | null;
  planningStatus: string;
  executionStatus: string | null;
  productionUnitGroupId: number;
  predecessorSequenceId: number | null;
  successorSequenceId: number | null;
}

export type GroupSequenceFormData = Modify<
  Omit<GroupSequence, 'planningStatus' | 'executionStatus'>,
  {
    id?: number;
    remark?: number;
    predecessorSequenceId?: number;
    successorSequenceId?: number;
    scenarioList: SequenceScenarioForm[];
  }
>;
