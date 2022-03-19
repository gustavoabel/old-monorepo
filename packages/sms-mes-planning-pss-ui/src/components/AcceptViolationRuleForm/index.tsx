/* eslint-disable @typescript-eslint/no-explicit-any */
import React, { useCallback, useState } from 'react';

import { getTokenData } from '@sms/plasma-security-ui';
import { Button, Col, Form, Notification, Row, Select, TextInput, useDataSource, Widget } from '@sms/plasma-ui';

import { useModalForm, useSequenceMaterials, useSequenceScenario } from '../..';
import { pssApi } from '../../services';
import { SequenceScenario } from '../../types/SequenceScenario';
import { StyledDivider } from './styles';

interface Props {
  item: Record<string, unknown>;
}

const AcceptViolationRuleForm: React.FC<Props> = ({ item }) => {
  const { setVisible } = useModalForm();
  const { selectedSequence, searchScenarioBySequence } = useSequenceScenario();
  const { selectedMaterials, getUnits } = useSequenceMaterials();
  const TokenData = getTokenData(process.env.REACT_APP_PORTAL_APLICATION_CODE || '');

  const scenario = item.scenario as SequenceScenario;

  const [hasAccepted, setHasAccepted] = useState(false);

  const { data: violationRulesList } = useDataSource(
    () =>
      pssApi.getComboSchedulingRuleViolation({
        data: {
          materialId: selectedMaterials.from?.material_id,
          sequenceItemId: selectedMaterials.from?.sequenceItemId,
        },
      }),
    [],
  );

  const handleSubmit = useCallback(
    async (formData) => {
      if (TokenData) {
        const responsible = `${TokenData.first_name} ${TokenData.last_name}`;

        const { ok } = await pssApi.acceptViolation({
          data: {
            schedulingRuleViolationId: formData.schedulingViolationRuleId,
            responsible,
          },
        });

        if (ok) {
          Notification.success('app.api.generic.save.success.message');
          searchScenarioBySequence(selectedSequence?.id || 0);
          setHasAccepted(true);
          return;
        }

        Notification.error('app.api.generic.error.message');
        return;
      }

      Notification.warning('app.api.generic.save.warning.message');
      return;
    },
    [TokenData, searchScenarioBySequence, selectedSequence?.id],
  );

  const handleCancel = useCallback(() => {
    if (hasAccepted) {
      getUnits(scenario?.id || 0);
    }

    setHasAccepted(false);
    setVisible(false);
  }, [getUnits, hasAccepted, scenario?.id, setVisible]);

  return (
    <>
      {selectedMaterials.from && (
        <Widget title={'Accept Rule Violation'}>
          <Row gutter={24}>
            <Col span={6}>
              <TextInput
                label="app.forms.materialId"
                name={`materialId`}
                max={255}
                disabled
                defaultValue={selectedMaterials.from.material_id}
              />
            </Col>
            <Col span={6}>
              <TextInput
                label="app.forms.position"
                name={`position`}
                max={255}
                disabled
                defaultValue={selectedMaterials.from.position}
              />
            </Col>
            <Col span={6}>
              <TextInput
                label="app.forms.steelGradeInt"
                name={`steelGradeInt`}
                max={255}
                disabled
                defaultValue={selectedMaterials.from.STEEL_GRADE_INT}
              />
            </Col>
            <Col span={6}>
              <TextInput
                label="app.forms.type"
                name={`type`}
                max={255}
                disabled
                defaultValue={selectedMaterials.from.type}
              />
            </Col>
          </Row>
          <StyledDivider />
          <Form maxWidth="100%" onSubmit={handleSubmit}>
            <Row gutter={24}>
              <Col span={6}>
                <Select
                  label="app.forms.violationRules"
                  name={`schedulingViolationRuleId`}
                  dataSource={violationRulesList}
                  labelField={(item) => String(item.name).replaceAll('_', ' ')}
                  valueField={(item) => String(item.id)}
                  required
                />
              </Col>
            </Row>
            <Row style={{ marginTop: 16 }} justify="end" gutter={24}>
              <Col>
                <Button title={'ui.generic.button.save'} type="primary" formEvent="submit" />
              </Col>
              <Col>
                <Button
                  title={hasAccepted ? 'ui.generic.button.finish' : 'ui.generic.button.cancel'}
                  type="default"
                  onClick={handleCancel}
                />
              </Col>
            </Row>
          </Form>
        </Widget>
      )}
    </>
  );
};

export default AcceptViolationRuleForm;
