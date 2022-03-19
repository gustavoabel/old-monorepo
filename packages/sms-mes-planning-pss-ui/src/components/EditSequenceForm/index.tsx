/* eslint-disable @typescript-eslint/no-explicit-any */
import React, { useCallback } from 'react';

import { Button, Col, Form, Row, Select, TextInput, Notification, DateTimePicker } from '@sms/plasma-ui';
import { Widget } from '@sms/plasma-ui/lib/components/Widget/Widget';
import moment from 'moment';

import { useModalForm, useSequenceScenario } from '../..';
import { pssApi } from '../../services';
import { GroupSequence } from '../../types/GroupSequence';
import CounterCharacter from '../CounterCharacter';

interface Props {
  item: Record<string, unknown>;
}

const EditSequenceForm: React.FC<Props> = ({ item }) => {
  const sequence = item.sequence as GroupSequence;
  const { setVisible } = useModalForm();
  const { searchScenarioBySequence, refetchGroupSequenceList } = useSequenceScenario();

  const handleSubmit = useCallback(
    async (formData) => {
      const editSequence = { id: sequence.id, ...formData };
      const response = await pssApi.updateSequence({ data: editSequence });
      if (response.ok) {
        Notification.success('app.api.generic.save.success.message');
        setVisible(false);
        if (refetchGroupSequenceList) {
          refetchGroupSequenceList();
        }
        searchScenarioBySequence(sequence?.id || 0);
      }

      return;
    },
    [refetchGroupSequenceList, searchScenarioBySequence, sequence.id, setVisible],
  );

  return (
    <Widget title={'Edit Sequence'}>
      <Form maxWidth="100%" onSubmit={handleSubmit}>
        <Row gutter={24}>
          <Col span={12}>
            <Select
              label="app.forms.productionUnitGroup"
              name="productionUnitGroupId"
              dataSource={pssApi.getAllProductionUnitGroup}
              labelField="name"
              valueField="id"
              disabled
              defaultValue={sequence.productionUnitGroupId}
            />
          </Col>
          <Col span={12}>
            <TextInput label="app.forms.name" name="name" defaultValue={sequence.name} />
          </Col>
        </Row>
        <Row gutter={24}>
          <Col span={12}>
            <Select
              label="app.forms.predecessor"
              name="predecessorSequenceId"
              dataSource={[]}
              labelField="name"
              valueField="id"
              required={false}
              defaultValue={sequence.predecessorSequenceId ? sequence.predecessorSequenceId : undefined}
            />
          </Col>
          <Col span={12}>
            <Select
              label="app.forms.successor"
              name="successorSequenceId"
              dataSource={[]}
              labelField="name"
              valueField="id"
              required={false}
              defaultValue={sequence.successorSequenceId ? sequence.successorSequenceId : undefined}
            />
          </Col>
        </Row>
        <Row gutter={24}>
          <Col span={12}>
            <DateTimePicker label="app.forms.startDate" name="startDate" defaultValue={moment(sequence.startDate)} />
          </Col>
        </Row>
        <Row gutter={24}>
          <Col span={24}>
            <CounterCharacter name="remark" defaultValue={sequence.remark ? sequence.remark : ''} />
          </Col>
        </Row>
        <Row style={{ marginTop: 16 }} justify="end" gutter={24}>
          <Col>
            <Button title={'Save'} type="primary" formEvent="submit" />
          </Col>
          <Col>
            <Button title="Cancel" type="default" onClick={() => setVisible(false)} />
          </Col>
        </Row>
      </Form>
    </Widget>
  );
};

export default EditSequenceForm;
