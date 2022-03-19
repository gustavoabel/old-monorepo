/* eslint-disable @typescript-eslint/no-explicit-any */
import React, { useCallback, useEffect, useState } from 'react';

import { getTokenData } from '@sms/plasma-security-ui';
import { Button, Col, Form, Notification, Row, Select, TextInput, useDataSource, Widget } from '@sms/plasma-ui';

import { pssApi } from '../../services';
import { MaterialAttributeTypes } from '../../types';
import { DynamicObject } from '../../types/DynamicObject';
import { GroupSequence } from '../../types/GroupSequence';
import { SequenceScenario } from '../../types/SequenceScenario';
import { UnitSequenceHeat } from '../../types/UnitSequence';
import { DateFormatter, useModalForm, useKPI, useSequenceMaterials, useSequenceScenario } from '../../utils';
import { StyledCol, StyledDivider, HighlightText, InfoCardList } from './styles';

import { InfoCard, PaginatedTable } from '..';

interface Props {
  item: Record<string, unknown>;
}

const AddMaterialsForm: React.FC<Props> = ({ item }) => {
  const { setVisible } = useModalForm();
  const { getKpiList } = useKPI();
  const { getUnits } = useSequenceMaterials();
  const { selectedSequence, searchScenarioBySequence } = useSequenceScenario();

  const sequence = item.sequence as GroupSequence;
  const scenario = item.scenario as SequenceScenario;

  const [materialsAdded, setMaterialsAdded] = useState<number>(0);
  const [selectedUnitSequence, setSelectedUnitSequence] = useState<number | null>(null);
  const [selectedSequenceItem, setSelectedSequenceItem] = useState<UnitSequenceHeat | null>(null);
  const [newMaterialOrder, setNewMaterialOrder] = useState<number | null>(null);
  const [selectedMaterialFilter, setSelectedMaterialFilter] = useState<number | null>(null);
  const [selectedPlanningHorizon, setSelectedPlanningHorizon] = useState<number | null>(null);
  const [materialSelected, setMaterialSelected] = useState<
    { unitSequenceId: string | number; sequenceItemId?: string | number; materialId: number; materialOrder?: number }[]
  >([]);
  const [heatList, setHeatList] = useState<UnitSequenceHeat[]>([]);
  const [columnDefinitions, setColumnDefinitions] = useState<DynamicObject[]>([]);
  const [maxSelectableRows, setMaxSelectableRows] = useState<number | boolean>(true);
  const [materialList, setMaterialList] = useState<DynamicObject[]>([]);
  const [filledWeight, setFilledWeight] = useState<number>(0);
  const [heatWeightLimit, setHeatWeightLimit] = useState<number>(0);
  const [firstEmptyRender, setFirstEmptyRender] = useState(true);
  const TokenData = getTokenData(process.env.REACT_APP_PORTAL_APLICATION_CODE || '');

  const tableHeight = window.innerHeight - window.innerHeight / 2;

  const { data: productionUnitList } = useDataSource(
    () =>
      pssApi.getCasterByScenario({
        data: {
          scenarioId: scenario?.id || 0,
        },
      }),
    [],
  );

  const { data: materialFilterList } = useDataSource(
    () =>
      pssApi.getComboMaterialFilter({
        params: { id: sequence?.productionUnitGroupId || 0 },
      }),
    [],
  );

  const { data: planningHorizonList } = useDataSource(
    () =>
      pssApi.getComboPlanningHorizon({
        params: {
          id: sequence?.productionUnitGroupId || 0,
        },
      }),
    [],
  );

  const handleFilter = useCallback(
    async (formData) => {
      if (selectedUnitSequence !== null && scenario !== null) {
        const { data } = await pssApi.getAvailableMaterialsToAdd({
          data: {
            productionUnitId: selectedUnitSequence,
            sequenceScenarioId: scenario.id,
            groupSequenceId: scenario.groupSequenceId,
            ...formData,
          },
        });

        if (data) {
          setMaterialList(data as DynamicObject[]);
          setFirstEmptyRender(false);
          return;
        }
      }

      Notification.error('Please select the Production Unit');
      return;
    },
    [selectedUnitSequence, scenario],
  );

  const setTableColumns = useCallback(
    async (productionUnitId) => {
      if (!productionUnitId || productionUnitId === null) return;

      let order;

      if (TokenData) {
        const user = `${TokenData.username}`;

        order = await pssApi.getCustomColumnOrder({
          params: {
            tableType: 'addMaterials',
            userId: user,
          },
        });
      }

      if (order && order.data) {
        setColumnDefinitions(JSON.parse(order.data));
      } else {
        const { data: materialAttributes } = await pssApi.getAddMaterialAttributes({
          params: {
            productionUnitId,
          },
        });

        if (materialAttributes && materialAttributes.length > 0) {
          const columns: DynamicObject[] = materialAttributes.map(
            (materialAttribute: MaterialAttributeTypes.MaterialAttribute) => {
              return {
                title: materialAttribute.name,
                field: materialAttribute.id.toString(),
                headerFilter: 'input',
                formatter: (cell: { getValue: () => string }) => {
                  if (materialAttribute.type === 'date') {
                    return DateFormatter(cell.getValue() as string, 'date');
                  }

                  return cell.getValue() as string;
                },
              };
            },
          );
          setColumnDefinitions(columns);
        } else {
          setColumnDefinitions([]);
        }
      }
    },
    [TokenData],
  );

  const getHeatList = useCallback(async (unitSequenceId) => {
    if (!unitSequenceId || unitSequenceId === null) return;

    try {
      const { data } = await pssApi.getHeatListByUnitSequence({
        data: { unitSequenceId },
      });

      if (!data) {
        setHeatList([]);
        return;
      }

      setHeatList(data);
    } catch (error) {
      throw new Error(`Get Heat List Error: ${error}`);
    }
  }, []);

  const getMaterialOrder = useCallback(
    async (sequenceItemId: number) => {
      if (!sequenceItemId || sequenceItemId === null) return;

      try {
        setSelectedSequenceItem(heatList.find((h) => h.sequenceItemId === sequenceItemId) || null);

        const { data } = await pssApi.getNewOutputOrder({
          data: { sequenceItemId },
        });

        if (!data) {
          setNewMaterialOrder(null);
          return;
        }

        setNewMaterialOrder(data);
      } catch (error) {
        throw new Error(`Get Material Order Error: ${error}`);
      }
    },
    [heatList],
  );

  const handleAdd = useCallback(async () => {
    const { ok } = await pssApi.addNewMaterial({ data: materialSelected });

    if (!ok) {
      Notification.error('Some problem ocurred while trying to add the material.');
      return;
    }

    if (!selectedSequenceItem) {
      getHeatList(selectedUnitSequence);
    }

    setMaterialsAdded((v) => v + materialSelected.length);
    getKpiList(scenario.id);
    getMaterialOrder(selectedSequenceItem?.sequenceItemId || 0);
    setMaterialSelected([]);
    handleFilter({
      materialFilterId: selectedMaterialFilter,
      planningHorizonId: selectedPlanningHorizon,
    });

    Notification.success('Material Added with Success.');
  }, [
    getHeatList,
    getKpiList,
    getMaterialOrder,
    handleFilter,
    materialSelected,
    scenario.id,
    selectedMaterialFilter,
    selectedPlanningHorizon,
    selectedSequenceItem,
    selectedUnitSequence,
  ]);

  const handleCancel = useCallback(() => {
    if (materialsAdded > 0) {
      getUnits(scenario?.id);
      searchScenarioBySequence(selectedSequence?.id || 0);
    }
    setVisible(false);
  }, [getUnits, materialsAdded, scenario?.id, searchScenarioBySequence, selectedSequence?.id, setVisible]);

  useEffect(() => {
    return () => {
      setSelectedUnitSequence(null);
      setSelectedSequenceItem(null);
      setNewMaterialOrder(null);
      setMaterialList([]);
      setMaterialSelected([]);
      setHeatList([]);
    };
  }, []);

  const handleColumnMoved = useCallback(
    async (data) => {
      const customColumns = [];
      for (let index = 0; index < data.getTable().columnManager.columns.length; index++) {
        customColumns.push({
          field: data.getTable().columnManager.columns[index].field,
        });
      }

      if (TokenData) {
        const user = `${TokenData.username}`;

        await pssApi.setCustomColumnOrder({
          data: {
            tableType: 'addMaterials',
            userId: user,
            columnOrder: JSON.stringify(customColumns),
          },
        });
      }
    },
    [TokenData],
  );

  const handleRowSelection = (data: any) => {
    if (data.length < 1) {
      setMaterialSelected([]);
      return;
    }

    const materialObject = [];

    for (let index = 0; index < data.length; index++) {
      materialObject.push({
        unitSequenceId: selectedUnitSequence || 0,
        sequenceItemId: selectedSequenceItem?.sequenceItemId,
        materialId: data[index]['id'],
        materialOrder: Number(newMaterialOrder) + index || 1,
      });
    }

    setMaterialSelected(materialObject);
    checkWeightAim(data);

    return;
  };

  const checkWeightAim = useCallback(
    async (selectedRows: any) => {
      let weightSum = 0;

      for (let index = 0; index < selectedRows.length; index++) {
        weightSum += Number(selectedRows[index][18]);
      }

      setFilledWeight(weightSum);

      if (productionUnitList && selectedUnitSequence) {
        const findCaster = productionUnitList.find((item) => item.id === selectedUnitSequence);
        if (findCaster) {
          setHeatWeightLimit(findCaster.maxHeatWeight);

          if (Math.round(weightSum) >= Math.round(findCaster.maxHeatWeight)) {
            setMaxSelectableRows(false);
          } else {
            setMaxSelectableRows(true);
          }
        }
      }
    },
    [productionUnitList, selectedUnitSequence],
  );

  useEffect(() => {
    if (productionUnitList) {
      const findCaster = productionUnitList.find((item) => item.id === selectedUnitSequence);
      if (findCaster) {
        setHeatWeightLimit(findCaster.maxHeatWeight);
      }
    }
  }, [productionUnitList, selectedUnitSequence]);

  return (
    <Widget title="Add Materials">
      <Row gutter={24}>
        <Col span={8}>
          <Select
            name="unitSequenceId"
            label="app.forms.productionUnit"
            labelField="productionUnitName"
            valueField="id"
            dataSource={productionUnitList}
            onChange={(value) => {
              setSelectedUnitSequence(Number(value));
              setNewMaterialOrder(null);
              getHeatList(Number(value));
              setTableColumns(value);
            }}
          />
        </Col>
        <Col span={8}>
          <Select
            name="inputMaterialId"
            label="app.forms.heat"
            placeholder="Select one heat or leave it blank for creating a new one"
            dataSource={heatList}
            labelField={(item) =>
              `${item.sequenceItemOrder} | Grade: ${item.steelGradeInt} | Weight: ${item.heatWeight}`
            }
            valueField="sequenceItemId"
            allowClear
            onChange={(value) => getMaterialOrder(Number(value))}
            onClear={() => {
              setSelectedSequenceItem(null);
              setNewMaterialOrder(null);
            }}
          />
        </Col>
        <Col span={8}>
          <TextInput
            name="newPosition"
            label="Material Position"
            value={
              selectedSequenceItem !== null && newMaterialOrder !== null
                ? `${selectedSequenceItem?.sequenceItemOrder}.${newMaterialOrder}`
                : ''
            }
            disabled
            readOnly
          />
        </Col>
      </Row>
      <StyledDivider />
      <Form initialValues={scenario} maxWidth="100%" onSubmit={handleFilter}>
        <Row gutter={24}>
          <Col span={8}>
            <Select
              name="materialFilterId"
              label="app.forms.materialFilter"
              labelField="name"
              valueField="id"
              dataSource={materialFilterList}
              required={false}
              allowClear
              onChange={(value) => setSelectedMaterialFilter(Number(value) || null)}
              onClear={() => setSelectedMaterialFilter(null)}
            />
          </Col>
          <Col span={8}>
            <Select
              name="planningHorizonId"
              label="app.forms.planningHorizon"
              labelField="name"
              valueField="id"
              dataSource={planningHorizonList}
              required={false}
              allowClear
              onChange={(value) => setSelectedPlanningHorizon(Number(value) || null)}
              onClear={() => setSelectedPlanningHorizon(null)}
            />
          </Col>
          <StyledCol span={8}>
            <Button title="Filter" type="primary" formEvent="submit" />
            <Button title="Clean Filter" type="default" formEvent="reset" />
          </StyledCol>
        </Row>
      </Form>
      <Row gutter={24}>
        <Col span={24}>
          {materialList.length > 0 && (
            <InfoCardList>
              <InfoCard
                label={'Filled Heat Weight'}
                value={materialSelected.length > 0 ? filledWeight : 0}
                hasLimit={heatWeightLimit}
              />
              <InfoCard label={'Max Heat Weight'} value={heatWeightLimit} />
              <InfoCard
                label={'Remaining Heat Weight'}
                value={
                  materialSelected.length > 0
                    ? filledWeight <= heatWeightLimit
                      ? heatWeightLimit - filledWeight
                      : 0
                    : heatWeightLimit
                }
              />
            </InfoCardList>
          )}
          <PaginatedTable
            firstEmptyRender={firstEmptyRender}
            data={materialList}
            maxSelectableRows={maxSelectableRows}
            columnDefinitions={columnDefinitions}
            tableHeight={tableHeight}
            handleColumnMoved={handleColumnMoved}
            handleRowSelection={handleRowSelection}
          />
        </Col>
      </Row>
      <Row style={{ marginTop: 16 }} justify="end" align="middle" gutter={24}>
        <Col>
          <HighlightText>
            {materialsAdded > 0 && `${materialsAdded} ${materialsAdded > 1 ? 'materials' : 'material'} has been added`}
          </HighlightText>
        </Col>
        <Col>
          <Button
            title={'ui.generic.button.add'}
            type="primary"
            disabled={selectedUnitSequence === null || materialSelected.length === 0 || filledWeight > heatWeightLimit}
            onClick={handleAdd}
          />
        </Col>
        <Col>
          <Button
            title={materialsAdded > 0 ? 'ui.generic.button.finish' : 'ui.generic.button.cancel'}
            type="default"
            onClick={handleCancel}
          />
        </Col>
      </Row>
    </Widget>
  );
};

export default AddMaterialsForm;
