import React, { useCallback, useState } from 'react';

import { navigate, Notification, withPage, WizardPage } from '@sms/plasma-ui';

import SchedulingRuleCodeForm from '../../components/SchedulingRuleForm/Code';
import SchedulingRuleFormFields from '../../components/SchedulingRuleForm/SchedulingRuleFormFields';
import { pssApi } from '../../services';
import { SchedulingRuleTypes } from '../../types';

const SchedulingRuleFormPage: React.FC = () => {
  const [schedulingRule, setSchedulingRule] = useState<SchedulingRuleTypes.SchedulingRule>();
  const [initialValues, setInitialValues] = useState<Record<string, unknown>>();

  const handleSubmit = useCallback(
    async (data: SchedulingRuleTypes.SchedulingRule) => {
      if (data && data !== null && schedulingRule && schedulingRule !== undefined) {
        const comments = schedulingRule.implementation.substring(0, schedulingRule.implementation.indexOf('function'));
        const implementationCleanned = schedulingRule.implementation.replace(comments, '');

        const response = await pssApi.createSchedulingRule({
          data: { ...data, implementation: implementationCleanned },
        });

        if (response.ok) {
          Notification.success('app.api.generic.save.success.message');
          navigate('/pss/schedulingRule');
        }
      }
    },
    [schedulingRule],
  );

  const handleSelectChange = useCallback((values: Record<string, unknown>) => {
    setInitialValues((x) => ({ ...x, ...values }));
  }, []);

  return (
    <WizardPage
      steps={[
        {
          title: 'app.common.general',
          controls: (
            <SchedulingRuleFormFields
              initialValues={initialValues}
              onSelectChange={handleSelectChange}
              setNewInitialValues={setInitialValues}
            />
          ),
          isFormItem: true,
        },
        {
          title: 'app.common.code',
          controls: (
            <SchedulingRuleCodeForm
              materialTypeId={schedulingRule?.materialTypeId}
              code={schedulingRule?.implementation}
              onCodeChanged={(value) =>
                setSchedulingRule({ ...schedulingRule, implementation: value } as SchedulingRuleTypes.SchedulingRule)
              }
            />
          ),
        },
      ]}
      wizard={{ title: 'Create new scheduling rule' }}
      values={initialValues}
      onNext={(next) => setSchedulingRule({ ...schedulingRule, ...(next as SchedulingRuleTypes.SchedulingRule) })}
      onPrevious={() => setInitialValues(schedulingRule)}
      onFinish={() => {
        if (schedulingRule) {
          handleSubmit(schedulingRule);
        }
      }}
    />
  );
};

export default withPage(SchedulingRuleFormPage);
