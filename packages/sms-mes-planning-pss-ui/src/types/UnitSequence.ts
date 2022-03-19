import { DynamicObject } from './DynamicObject';

export interface UnitSequenceHeat {
  sequenceItemId: number;
  sequenceItemOrder: number;
  heatWeight: string;
  steelGradeInt: string;
}

export interface UnitSequence {
  id: number;
  productionUnitName: string;
  productionUnitId: number;
  sequenceScenarioVersionId: number;
  maxHeatWeight: number;
}

export interface UnitSequenceMaterialList {
  [key: string]: DynamicObject[];
}

export interface UnitSequenceSum {
  sumOfWeight: number;
  sumOfLength: number;
}
