import React, { useCallback, useMemo } from 'react';

import { Button, Col, Select, Switch, TextInput, useDataSource, withComponent } from '@sms/plasma-ui';

import { pssApi } from '../../services';
import { useSequenceForm } from '../../utils/';
import { ButtonRow, Container } from './styles';

interface Props {
  initialValues?: Record<string, string | number | null>;
}

const ScenarioSimpleForm: React.FC<Props> = () => {
  const { sequence, setSequence } = useSequenceForm();

  const { data: planningHorizonList } = useDataSource(
    () => pssApi.getComboPlanningHorizon({ params: { id: sequence?.productionUnitGroupId || 0 } }),
    [],
  );

  const { data: materialFilterList } = useDataSource(
    () => pssApi.getComboMaterialFilter({ params: { id: sequence?.productionUnitGroupId || 0 } }),
    [],
  );

  const updateSequence = useCallback(
    (list) => {
      const newSequence = {
        ...sequence,
        scenarioList: list,
      };

      setSequence(newSequence);
    },
    [sequence, setSequence],
  );

  const handleNewScenario = () => {
    const newScenarioList = [
      ...sequence.scenarioList,
      {
        name: '',
        planningHorizonId: undefined,
        materialFilterId: undefined,
        useOptimizer: false,
      },
    ];
    updateSequence(newScenarioList);
  };

  const handleSwitch = useCallback(
    (value, index) => {
      const newScenarioList = sequence.scenarioList.map((scenario, i) => {
        if (i === index) {
          return {
            ...scenario,
            useOptimizer: value,
          };
        }

        return scenario;
      });

      updateSequence(newScenarioList);
    },
    [sequence, updateSequence],
  );

  const ScenarioFormList = useMemo(
    () => (
      <>
        {sequence.scenarioList.map((s, i) => (
          <Container key={s.id || i} gutter={24}>
            <Col span={6}>
              <TextInput
                label="app.forms.name"
                name={`scenarioName${i}`}
                max={255}
                defaultValue={s.name}
                onChange={(e) => (s.name = e.target.value)}
              />
            </Col>
            <Col span={6}>
              <Select
                label="app.forms.planningHorizon"
                name={`planningHorizonId${i}`}
                dataSource={planningHorizonList}
                labelField="name"
                valueField="id"
                required
                defaultValue={s.planningHorizonId}
                onChange={(value) => (s.planningHorizonId = Number(value))}
              />
            </Col>
            <Col span={6}>
              <Select
                label="app.forms.materialFilter"
                name={`materialFilterId${i}`}
                dataSource={materialFilterList}
                labelField="name"
                valueField="id"
                required
                defaultValue={s.materialFilterId}
                onChange={(value) => (s.materialFilterId = Number(value))}
              />
            </Col>
            <Col span={6}>
              <Switch
                label="app.forms.useOptimizer"
                name={`useOptimizer${i}`}
                checked={s.useOptimizer}
                onChange={(value) => handleSwitch(value, i)}
              />
            </Col>
          </Container>
        ))}
      </>
    ),
    [handleSwitch, materialFilterList, planningHorizonList, sequence],
  );

  return (
    <>
      <ButtonRow gutter={24}>
        <Col span={24}>
          <Button.New onClick={handleNewScenario} />
        </Col>
      </ButtonRow>
      {ScenarioFormList}
    </>
  );
};

export default withComponent(ScenarioSimpleForm);
