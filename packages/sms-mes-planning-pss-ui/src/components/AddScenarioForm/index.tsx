/* eslint-disable @typescript-eslint/no-explicit-any */
import React, { useCallback } from 'react';

import { Button, Col, Form, Row, Select, Switch, TextInput, useDataSource, Notification } from '@sms/plasma-ui';
import { Widget } from '@sms/plasma-ui/lib/components/Widget/Widget';

import { pssApi } from '../../services';
import { GroupSequence } from '../../types/GroupSequence';
import { SequenceScenario } from '../../types/SequenceScenario';
import { useModalForm, useSequenceScenario } from '../../utils/hooks';

interface Props {
  item: Record<string, unknown>;
  isEdit?: boolean;
}

const AddScenarioForm: React.FC<Props> = ({ item, isEdit }) => {
  const sequence = item.sequence as GroupSequence;
  const scenario = item.scenario as SequenceScenario;
  const { setVisible } = useModalForm();
  const { searchScenarioBySequence } = useSequenceScenario();

  const { data: planningHorizonList } = useDataSource(
    () => pssApi.getComboPlanningHorizon({ params: { id: sequence?.productionUnitGroupId || 0 } }),
    [],
  );

  const { data: materialFilterList } = useDataSource(
    () => pssApi.getComboMaterialFilter({ params: { id: sequence?.productionUnitGroupId || 0 } }),
    [],
  );

  const handleSubmit = useCallback(
    async (formData) => {
      let response;

      if (isEdit) {
        const sequenceEditScenario = { groupSequenceId: sequence.id, id: scenario.id, ...formData };
        response = await pssApi.updateSequenceScenario({ data: sequenceEditScenario });
      } else {
        const sequenceAddScenario = { groupSequenceId: sequence.id, ...formData };
        response = await pssApi.createSequenceScenario({ data: sequenceAddScenario });
      }

      if (response.ok) {
        Notification.success('app.api.generic.save.success.message');
        setVisible(false);
        searchScenarioBySequence(sequence?.id || 0);
      }

      return;
    },
    [isEdit, scenario.id, searchScenarioBySequence, sequence.id, setVisible],
  );

  return (
    <Widget title={isEdit ? 'Edit Scenario' : 'Add Scenario'}>
      <Form maxWidth="100%" onSubmit={handleSubmit}>
        <Row gutter={24}>
          <Col span={6}>
            <TextInput
              label="app.forms.name"
              name={`name`}
              max={255}
              defaultValue={isEdit ? scenario.name : undefined}
            />
          </Col>
          <Col span={6}>
            <Select
              label="app.forms.planningHorizon"
              name={`planningHorizonId`}
              dataSource={planningHorizonList}
              labelField="name"
              valueField="id"
              defaultValue={isEdit ? scenario.planningHorizonId : undefined}
              required
            />
          </Col>
          <Col span={6}>
            <Select
              label="app.forms.materialFilter"
              name={`materialFilterId`}
              dataSource={materialFilterList}
              labelField="name"
              valueField="id"
              defaultValue={isEdit ? scenario.materialFilterId : undefined}
              required
            />
          </Col>
          <Col span={6}>
            <Switch
              label="app.forms.useOptimizer"
              name={`useOptimizer`}
              defaultChecked={isEdit ? scenario.useOptimizer : false}
            />
          </Col>
        </Row>
        <Row style={{ marginTop: 16 }} justify="end" gutter={24}>
          <Col>
            <Button title={isEdit ? 'Save' : 'Add'} type="primary" formEvent="submit" />
          </Col>
          <Col>
            <Button title="Cancel" type="default" onClick={() => setVisible(false)} />
          </Col>
        </Row>
      </Form>
    </Widget>
  );
};

export default AddScenarioForm;
