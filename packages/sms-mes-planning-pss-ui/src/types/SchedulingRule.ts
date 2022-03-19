export type SchedulingRule = {
  id: number;
  name: string;
  remark: string;
  implementation: string;
  productionUnitId: number | string;
  materialAttributeDefinitionId?: number | string;
  materialTypeId?: number | string;
};
