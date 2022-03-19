export type MaterialFilter = {
  id: number;
  productionUnitGroupId: number | string;
  name: string;
  description?: string;
  expression: string;
  isDefault: boolean;
};
