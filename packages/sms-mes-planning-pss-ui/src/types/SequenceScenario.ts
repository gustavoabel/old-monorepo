import { Modify } from '../utils';

export interface SequenceScenario {
  id: number;
  groupSequenceId: number;
  name: string;
  planningHorizonId?: number;
  materialFilterId?: number;
  useOptimizer: boolean;
  rating: number;
  selected: boolean;
  materials: number;
  ruleViolation: number;
  materialFilterName: string;
  isOptimized: boolean;
}

export type SequenceScenarioForm = Modify<
  SequenceScenario,
  {
    id?: number;
    groupSequenceId?: number;
    name: string;
    planningHorizonId?: number;
    materialFilterId?: number;
    useOptimizer: boolean;
    rating?: number;
  }
>;
