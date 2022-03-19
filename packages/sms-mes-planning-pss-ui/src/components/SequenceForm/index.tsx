import React from 'react';

import { Row, Col, TextInput, TextArea, Select, DateTimePicker } from '@sms/plasma-ui';

import { pssApi } from '../../services';
import CounterCharacter from '../CounterCharacter';

// import { Container } from './styles';

interface Props {
  initialValues?: Record<string, string | number | null>;
}

const SequenceForm: React.FC<Props> = (initialValues) => {
  return (
    <>
      <Row gutter={24}>
        <Col span={12}>
          <Select
            label="app.forms.productionUnitGroup"
            name="productionUnitGroupId"
            dataSource={pssApi.getAllProductionUnitGroup}
            labelField="name"
            valueField="id"
          />
        </Col>
        <Col span={12}>
          <TextInput label="app.forms.name" name="name" />
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
          />
        </Col>
      </Row>
      <Row gutter={24}>
        <Col span={12}>
          <DateTimePicker label="app.forms.startDate" name="startDate" />
        </Col>
      </Row>
      <Row gutter={24}>
        <Col span={24}>
          <CounterCharacter name="remark" />
        </Col>
      </Row>
    </>
  );
};

export default SequenceForm;
