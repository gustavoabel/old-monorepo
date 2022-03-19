import React, { memo, useCallback, useEffect, useMemo, useState } from 'react';

import { Split, usePage } from '@sms/plasma-ui';

import SequenceGridMock from '../../mock';
import { SequenceGridTypes } from '../../types';
import { useSequenceMaterials } from '../../utils/hooks';
import MaterialsTable from '../MaterialsTable';
import { Panel, Wrapper } from './styles';

import { NoDataMessage } from '..';

const DynamicSplit: React.FC = () => {
  const { itemId } = usePage('itemId');
  const {
    unitList,
    updateMaterialList,
    setUpdateMaterialList,
    getUnits,
    handleMaterialSelection,
  } = useSequenceMaterials();

  const grid = SequenceGridMock.SequenceGrid;
  const [tableSize, setTableSize] = useState([50, 50]);

  const targets = useMemo(
    () =>
      grid.format === 'columns'
        ? grid.columns?.map((c) => c.rows.map((r) => r.unit.name))
        : grid.rows?.map((r) => r.columns.map((c) => c.unit.name)),
    [grid],
  );

  const GridColumn = useCallback(
    (panels) => {
      const allTargets = (targets?.flat() ?? []) as string[];

      if (panels.length > 1) {
        return (
          <Split
            sizes={panels.map(() => (grid.format === 'columns' ? 100 / panels.length - 2.25 : 100 / panels.length))}
            minSize={300}
            expandToMin={false}
            snapOffset={30}
            dragInterval={1}
            direction={grid.format !== 'columns' ? 'horizontal' : 'vertical'}
            style={{ margin: 0 }}
            onDragEnd={(sizes: number[]) => setTableSize(sizes)}
          >
            {panels.map((row: SequenceGridTypes.GridContent, index: number) => {
              const ti = targets?.findIndex((t) => !t.includes(row.unit.name)) ?? -1;
              const target = !targets || ti === -1 ? [] : targets[ti];

              return (
                <Panel key={row.unit.id + '_Key'}>
                  {unitList[row.unit.name] && unitList[row.unit.name].length > 0 ? (
                    <MaterialsTable
                      unit={row.unit}
                      materials={unitList[row.unit.name]}
                      size={tableSize[index]}
                      target={target}
                      allTargets={allTargets}
                    />
                  ) : (
                    <NoDataMessage tableTitle={row.unit.name} />
                  )}
                </Panel>
              );
            })}
          </Split>
        );
      }

      const index = targets?.findIndex((t) => !t.includes(panels[0].unit.name)) ?? -1;
      const target = !targets || index === -1 ? [] : targets[index];

      return (
        <Panel key={panels[0].unit.id + '_Key'}>
          {unitList[panels[0].unit.name] && unitList[panels[0].unit.name].length > 0 ? (
            <MaterialsTable
              unit={panels[0].unit}
              materials={unitList[panels[0].unit.name]}
              target={target}
              allTargets={allTargets}
            />
          ) : (
            <NoDataMessage tableTitle={panels[0].unit.name} />
          )}
        </Panel>
      );
    },
    [grid.format, tableSize, unitList, targets],
  );

  useEffect(() => {
    handleMaterialSelection();

    if (itemId) {
      getUnits(itemId);
    }
  }, [getUnits, handleMaterialSelection, itemId]);

  useEffect(() => {
    if (updateMaterialList) {
      if (itemId) {
        getUnits(itemId);
        setUpdateMaterialList(false);
      }
    }
  }, [getUnits, itemId, setUpdateMaterialList, updateMaterialList]);

  return (
    <Wrapper>
      <Split
        sizes={[47.75, 47.75]}
        minSize={grid.format === 'columns' ? 300 : 100}
        expandToMin={false}
        snapOffset={30}
        dragInterval={1}
        direction={grid.format === 'columns' ? 'horizontal' : 'vertical'}
        style={{ maxHeight: '80vh' }}
      >
        {grid.format === 'columns'
          ? grid.columns?.map((column) => GridColumn(column.rows))
          : grid.rows?.map((row) => GridColumn(row.columns))}
      </Split>
    </Wrapper>
  );
};

export default memo(DynamicSplit);
