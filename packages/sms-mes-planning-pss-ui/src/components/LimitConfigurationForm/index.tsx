import React from 'react';

import { Row, Col, NumberInput } from '@sms/plasma-ui';

const LimitConfigurationForm: React.FC = () => {
  return (
    <Row gutter={24}>
      <Col>
        <NumberInput label="app.forms.minHeatWeight" name="minHeatWeight" />
      </Col>
      <Col>
        <NumberInput label="app.forms.maxHeatWeight" name="maxHeatWeight" />
      </Col>
      <Col>
        <NumberInput label="app.forms.minSequenceSize" name="minSequenceSize" />
      </Col>
      <Col>
        <NumberInput label="app.forms.maxSequenceSize" name="maxSequenceSize" />
      </Col>
    </Row>
  );
};

export default LimitConfigurationForm;
