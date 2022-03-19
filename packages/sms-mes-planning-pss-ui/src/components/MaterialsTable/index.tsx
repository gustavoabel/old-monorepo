/* eslint-disable @typescript-eslint/no-explicit-any */
import React, { memo, useCallback, useState } from 'react';

import {
  ColumnDefinition,
  EventListener,
  RowComponent,
  Tabulator,
  EventEmitter,
  usePage,
  Notification,
} from '@sms/plasma-ui';

import { pssApi } from '../../services';
import { DynamicObject } from '../../types/DynamicObject';
import { MaterialMovementRequestBody } from '../../types/Material';
import { ProductionUnit } from '../../types/ProductionUnit';
import { UniqueColumnsList, DateFormatter } from '../../utils';
import { GetRowComponentData } from '../../utils';
import { useSequenceScenario, useSequenceMaterials } from '../../utils/hooks';
import MaterialDataTable from './MaterialDataTable';
import { Container } from './styles';

interface Props {
  materials: DynamicObject[] | undefined;
  unit: ProductionUnit;
  size?: number;
  target: string[];
  allTargets: string[];
}

const MaterialsTable: React.FC<Props> = ({ unit, size, materials, allTargets, target }) => {
  const { handleMaterialSelection, getUnits } = useSequenceMaterials();
  const { selectedSequence, searchScenarioBySequence } = useSequenceScenario();
  const { itemId } = usePage('itemId');

  const [dataTable, setDataTable] = useState<Tabulator<DynamicObject>>();

  const searchRowValue = useCallback(
    (data: DynamicObject, row: RowComponent<DynamicObject>) => {
      row.getTreeChildren()?.forEach((t) => {
        searchRowValue(data, t);
      });

      const values = row.getData() as DynamicObject;
      if (values['PS_PIECE_ID'] === data['PS_PIECE_ID']) {
        row.select();
        handleMaterialSelection(data, row.getData());
      }
    },
    [handleMaterialSelection],
  );

  const hasViolations = useCallback((violations: DynamicObject[] | undefined) => {
    return violations && violations.length > 0;
  }, []);

  const hasChildren = useCallback(
    (keys: string[], items: DynamicObject[]) => {
      const children = keys.findIndex((key) => key === '_children');
      let currentColumns: ColumnDefinition<any>[] = [];
      let childColumns: ColumnDefinition<any>[] = [];

      if (children > 0) {
        if (items.length > 0) {
          const currentKeys = Object.keys(items[0]._children[0]);
          currentColumns = currentKeys
            .filter(
              (key: string) =>
                key !== 'id' &&
                key !== '_children' &&
                key !== 'productionUnitName' &&
                key !== 'sequenceItemId' &&
                key !== 'violations',
            )
            .map((key: string) => ({
              title: key.replaceAll('_', ' '),
              field: key,
              headerSort: false,
              formatter: (cell) => {
                const text = cell.getValue() as string;
                const data = cell.getData() as any;
                const element = cell.getElement();

                if (hasViolations(data.violations)) {
                  const errorIndex = data.violations.findIndex((v: Record<string, any>) =>
                    key.includes(v.materialAttributeDefinitionName),
                  );

                  if (errorIndex >= 0) {
                    element.style.fontWeight = 'bold';
                    element.style.border = '2px solid #E3000F';
                    element.style.color = '#E3000F';
                  }
                }

                if (data.type.includes('Group')) {
                  if (key === 'HEAT_GROUP_WEIGHT') {
                    let totalWeight = 0;

                    data._children.forEach((heatElement: DynamicObject) => {
                      const weightKey = Object.keys(heatElement).find((key) => key.includes('HEAT_WEIGHT'));
                      if (weightKey) {
                        totalWeight += Number(heatElement[weightKey]);
                      }
                    });

                    return totalWeight.toFixed(2);
                  }

                  if (key === 'STEEL_GRADE_INT') {
                    const steelGradeGroup = Object.keys(data._children[0]).find((key) =>
                      key.includes('STEEL_GRADE_INT'),
                    );
                    if (steelGradeGroup) {
                      return data._children[0][steelGradeGroup];
                    }
                  }
                }

                if (key.includes('DATE')) {
                  return DateFormatter(text, 'date');
                }

                if (!text || text === '' || text === null) {
                  return '-';
                }

                return text;
              },
            }));

          childColumns = hasChildren(currentKeys, items[0]._children);
        }
      }

      return UniqueColumnsList(currentColumns.concat(childColumns));
    },
    [hasViolations],
  );

  const tableColumns = useCallback(() => {
    if (materials && materials !== null && materials.length > 0) {
      const baseColumns: ColumnDefinition<any>[] = [
        {
          title: 'position',
          field: 'position',
          headerSort: false,
        },
        {
          title: 'material id',
          field: 'material_id',
          headerSort: false,
        },
      ];
      const matKeys: string[] = Object.keys(materials[0]);
      let childColumns: ColumnDefinition<any>[] = [];
      const parentColumns: ColumnDefinition<any>[] = matKeys
        .filter(
          (key: string) =>
            key !== 'id' &&
            key !== '_children' &&
            key !== 'productionUnitName' &&
            key !== 'sequenceItemId' &&
            key !== 'violations',
        )
        .map((key: string) => {
          return {
            title: key.replaceAll('_', ' '),
            field: key,
            headerSort: false,
            formatter: (cell) => {
              const text = cell.getValue() as string;
              const data = cell.getData() as any;
              const element = cell.getElement();

              if (hasViolations(data.violations)) {
                const errorIndex = data.violations.findIndex((v: Record<string, any>) =>
                  key.includes(v.materialAttributeDefinitionName),
                );

                if (errorIndex >= 0) {
                  element.style.fontWeight = 'bold';
                  element.style.border = '2px solid #E3000F';
                  element.style.color = '#E3000F';
                }
              }

              if (data.type.includes('Group')) {
                if (key === 'HEAT_GROUP_WEIGHT') {
                  let totalWeight = 0;

                  data._children.forEach((heatElement: DynamicObject) => {
                    const weightKey = Object.keys(heatElement).find((key) => key.includes('HEAT_WEIGHT'));
                    if (weightKey) {
                      totalWeight += Number(heatElement[weightKey]);
                    }
                  });

                  return totalWeight.toFixed(2);
                }

                if (key === 'STEEL_GRADE_INT') {
                  const steelGradeGroup = Object.keys(data._children[0]).find((key) => key.includes('STEEL_GRADE_INT'));
                  if (steelGradeGroup) {
                    return data._children[0][steelGradeGroup];
                  }
                }
              }

              if (key.includes('DATE')) {
                return DateFormatter(text, 'date');
              }

              if (!text || text === '' || text === null) {
                return '-';
              }

              return text;
            },
          };
        });

      childColumns = hasChildren(matKeys, materials);
      const columns = UniqueColumnsList(baseColumns.concat(parentColumns, childColumns));
      return columns;
    }
    return [];
  }, [hasChildren, hasViolations, materials]);

  const materialMove = useCallback(
    async (data: MaterialMovementRequestBody) => {
      try {
        const { ok } = await pssApi.moveMaterial({ data });

        if (!ok) {
          Notification.error('It was not possible to move the material.');
          return;
        }

        Notification.success('Material moved with success.');
        if (itemId) {
          getUnits(itemId);
          searchScenarioBySequence(selectedSequence?.id || 0);
        }
      } catch (err) {
        Notification.error('Something went wrong when trying to move the material.');
      }
    },
    [getUnits, itemId, searchScenarioBySequence, selectedSequence?.id],
  );

  const handleMovement = useCallback(
    (data: RowComponent<any>) => {
      const { prevLine, currentLine, nextLine } = GetRowComponentData(data);
      const currentLineType: string = currentLine.type ? currentLine.type.toLowerCase() : 'coil';

      switch (currentLineType) {
        case 'heat':
          if (!prevLine) {
            if (String(currentLine.position) !== String(1)) {
              materialMove({
                moveType: 'first',
                materialType: 'heat',
                oldPosition: currentLine.position,
                sequenceItemId: currentLine.sequenceItemId,
              });
            }
          } else if (!nextLine) {
            if (String(prevLine.position) !== String(1)) {
              materialMove({
                moveType: 'last',
                materialType: 'heat',
                sequenceItemId: currentLine.sequenceItemId,
                oldPosition: currentLine.position,
              });
            }
          } else {
            if (nextLine.type.toLowerCase() === 'slab') {
              Notification.error('app.sequence.table.movementNotEnable');
            } else if (prevLine.type.toLowerCase() === 'heat') {
              materialMove({
                moveType: 'middle',
                materialType: 'heat',
                oldPosition: currentLine.position,
                newPositon: Number(prevLine.position) + 1,
                sequenceItemId: currentLine.sequenceItemId,
              });
            } else if (prevLine.type.toLowerCase() === 'slab') {
              const prevLinePosition: number = prevLine.position.split('.')[0];
              materialMove({
                moveType: 'middle',
                materialType: 'heat',
                oldPosition: currentLine.position,
                newPositon: Number(prevLinePosition) + 1,
                sequenceItemId: currentLine.sequenceItemId,
              });
            } else {
              Notification.error('app.sequence.table.movementNotEnable');
            }
          }

          break;

        case 'slab':
          if (!prevLine) {
            Notification.error('app.sequence.table.movementNotEnable');
          } else if (!nextLine) {
            const currentLinePosition: number[] = currentLine.position.split('.');

            if (prevLine.type.toLowerCase() === 'heat') {
              Notification.error('app.sequence.table.movementNotEnable');
            } else if (prevLine.type.toLowerCase() === 'slab') {
              if (prevLine.sequenceItemId !== currentLine.sequenceItemId) {
                Notification.error('app.sequence.table.movementNotEnable');
              } else {
                materialMove({
                  moveType: 'last',
                  materialType: 'slab',
                  materialId: currentLine.material_id,
                  sequenceItemId: currentLine.sequenceItemId,
                  oldPosition: currentLinePosition[1],
                });
              }
            }
          } else {
            const currentLinePosition: number[] = currentLine.position.split('.');
            const prevLinePosition: number[] = prevLine.position.split('.');

            if (prevLine.type.toLowerCase() === 'heat') {
              if (nextLine.type.toLowerCase() === 'heat') {
                Notification.error('app.sequence.table.movementNotEnable');
              } else {
                if (prevLine.sequenceItemId !== currentLine.sequenceItemId) {
                  Notification.error('app.sequence.table.movementNotEnable');
                } else {
                  materialMove({
                    moveType: 'first',
                    materialType: 'slab',
                    materialId: currentLine.material_id,
                    sequenceItemId: currentLine.sequenceItemId,
                    oldPosition: currentLinePosition[1],
                  });
                }
              }
            } else {
              if (nextLine.type.toLowerCase() === 'heat') {
                if (prevLine.sequenceItemId !== currentLine.sequenceItemId) {
                  Notification.error('app.sequence.table.movementNotEnable');
                } else {
                  materialMove({
                    moveType: 'last',
                    materialType: 'slab',
                    materialId: currentLine.material_id,
                    sequenceItemId: currentLine.sequenceItemId,
                    oldPosition: currentLinePosition[1],
                  });
                }
              } else {
                if (prevLine.sequenceItemId !== currentLine.sequenceItemId) {
                  Notification.error('app.sequence.table.movementNotEnable');
                } else {
                  materialMove({
                    moveType: 'middle',
                    materialType: 'slab',
                    materialId: currentLine.material_id,
                    sequenceItemId: currentLine.sequenceItemId,
                    oldPosition: currentLinePosition[1],
                    newPositon: Number(prevLinePosition[1]),
                  });
                }
              }
            }
          }
          break;

        case 'coil':
          if (!prevLine) {
            if (String(currentLine.position) !== String(1)) {
              materialMove({
                moveType: 'first',
                materialType: 'coil',
                oldPosition: currentLine.position,
                sequenceItemId: currentLine.sequenceItemId,
              });
            }
          } else if (!nextLine) {
            if (String(prevLine.position) !== String(1)) {
              materialMove({
                moveType: 'last',
                materialType: 'coil',
                oldPosition: currentLine.position,
                sequenceItemId: currentLine.sequenceItemId,
              });
            }
          } else {
            materialMove({
              moveType: 'middle',
              materialType: 'coil',
              oldPosition: currentLine.position,
              newPositon: Number(prevLine.position) + 1,
              sequenceItemId: currentLine.sequenceItemId,
            });
          }

          break;

        default:
          Notification.error('app.sequence.table.movementNotEnable');
          break;
      }
    },
    [materialMove],
  );

  const handleRowClick = useCallback(
    (_, row: RowComponent<any>) => {
      dataTable?.deselectRow();
      row.select();

      allTargets.forEach((name) => {
        if (name !== unit.name) EventEmitter.emit(`deselect-row-event-${name}`);
      });
      target.forEach((name) => EventEmitter.emit(`select-row-event-${name}`, row.getData()));
    },
    [dataTable, target, allTargets, unit.name],
  );

  const handleDeselectRow = useCallback(() => {
    dataTable?.deselectRow();
  }, [dataTable]);

  const handleSelectRow = useCallback(
    (data: DynamicObject) => {
      dataTable?.getRows().forEach((row) => {
        searchRowValue(data, row);
      });
    },
    [dataTable, searchRowValue],
  );

  const handleRowFormat = useCallback(
    (row: RowComponent<any>) => {
      const element = row.getElement();
      const data = row.getData() as any;

      if (hasViolations(data.violations)) {
        element.style.backgroundColor = '#FFF1F1';
      }

      return <div dangerouslySetInnerHTML={{ __html: String(element) }} />;
    },
    [hasViolations],
  );

  return (
    <Container size={size}>
      <MaterialDataTable
        data={materials && materials !== null ? materials : []}
        title={unit.name}
        columns={tableColumns()}
        onReady={(table) => setDataTable(table)}
        onClick={handleRowClick}
        onMoved={handleMovement}
        onRowFormat={handleRowFormat}
      />
      <EventListener type={`deselect-row-event-${unit.name}`} listener={handleDeselectRow} />
      <EventListener type={`select-row-event-${unit.name}`} listener={handleSelectRow} />
    </Container>
  );
};

export default memo(MaterialsTable);
