import { ProductionUnit } from './ProductionUnit';

export type GridContent = {
  unit: ProductionUnit;
};

type GridColumnsFormat = {
  rows: GridContent[];
};

type GridRowsFormat = {
  columns: GridContent[];
};

export type DynamicGridLayout = {
  format: 'columns' | 'rows';
  rows?: GridRowsFormat[];
  columns?: GridColumnsFormat[];
};
