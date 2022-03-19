export type PlanningHorizon = {
  id: number;
  name: string;
  description: string;
  horizon: number;
  isDefault: boolean;
  productionUnitGroupId: number;
  materialAttributeDefinitionId: number;
};
