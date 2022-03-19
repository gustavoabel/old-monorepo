import React, { useCallback, useEffect, useState } from 'react';

import {
  Form,
  GridView,
  HeaderProps,
  MasterDetailPage,
  Notification,
  usePage,
  Widget,
  withComponent,
} from '@sms/plasma-ui';

import SchedulingRuleCodeForm from '../../components/SchedulingRuleForm/Code';
import SchedulingRuleFormFields from '../../components/SchedulingRuleForm/SchedulingRuleFormFields';
import { pssApi } from '../../services';
import { SchedulingRuleTypes } from '../../types';

interface Props {
  refetchSchedulingRuleList?: () => Promise<void>;
  master: React.ReactNode;
  header: Omit<HeaderProps<unknown>, 'enableGoBack'>;
}

const SchedulingRuleGeneralView: React.FC<Props> = ({ refetchSchedulingRuleList, master, header }) => {
  const { masterItem } = usePage('masterItem');
  const item = masterItem as SchedulingRuleTypes.SchedulingRule;
  const [schedulingRule, setSchedulingRule] = useState<SchedulingRuleTypes.SchedulingRule>(item);
  const [newInitialValues, setNewInitialValues] = useState<SchedulingRuleTypes.SchedulingRule>();

  useEffect(() => {
    if (item) {
      setSchedulingRule(item);
    }
  }, [item, setSchedulingRule]);

  const handleSubmit = useCallback(
    async (data: SchedulingRuleTypes.SchedulingRule) => {
      if (data && data !== null) {
        const comments = schedulingRule.implementation.substring(0, schedulingRule.implementation.indexOf('function'));
        const implementationCleanned = schedulingRule.implementation.replace(comments, '');

        const { ok } = await pssApi.updateSchedulingRule({
          data: { ...data, id: item.id, implementation: implementationCleanned },
        });

        if (ok) {
          if (refetchSchedulingRuleList) {
            refetchSchedulingRuleList();
          }
          Notification.success('app.api.generic.save.success.message');
        }
      }
    },
    [item, refetchSchedulingRuleList, schedulingRule],
  );

  const onMaterialTypeChanged = useCallback((value: number) => {
    setSchedulingRule((prevState) => ({ ...prevState, materialTypeId: value }));
  }, []);

  return (
    <MasterDetailPage master={master} header={header}>
      <GridView id="general" title="app.common.general">
        <Widget>
          <Form
            initialValues={newInitialValues || item}
            onSubmit={(data) => handleSubmit(data)}
            maxWidth="100%"
            showSave
          >
            <SchedulingRuleFormFields
              initialValues={schedulingRule}
              onMaterialTypeChanged={onMaterialTypeChanged}
              setNewInitialValues={setNewInitialValues}
            />
          </Form>
        </Widget>
      </GridView>
      <GridView id="code" title="app.common.code">
        <Widget>
          <SchedulingRuleCodeForm
            code={schedulingRule?.implementation}
            onCodeChanged={(implementation) => setSchedulingRule({ ...schedulingRule, implementation })}
            onSubmit={() => handleSubmit(schedulingRule)}
            isCodeValidInitialState
            materialTypeId={Number(schedulingRule?.materialTypeId)}
          />
        </Widget>
      </GridView>
    </MasterDetailPage>
  );
};

export default withComponent(SchedulingRuleGeneralView);
