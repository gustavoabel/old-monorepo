import React, { useCallback, useState } from 'react';

import { Notification, StepsStepProps, WizardPage, withPage, navigate } from '@sms/plasma-ui';

import { ScenarioSimpleForm } from '../../components/ScenarioForm';
import SequenceForm from '../../components/SequenceForm';
import { pssApi } from '../../services';
import { GroupSequenceTypes } from '../../types';
import { GroupSequenceFormContext } from '../../utils';

const SequenceFormPage: React.FC = () => {
  const [sequence, setSequence] = useState<GroupSequenceTypes.GroupSequenceFormData>({
    productionUnitGroupId: 0,
    name: '',
    startDate: new Date(),
    scenarioList: [],
  });

  const handleNext = useCallback(
    (formData?: GroupSequenceTypes.GroupSequenceFormData) => {
      if (!formData) {
        return;
      }

      setSequence({ ...sequence, ...formData });
    },
    [sequence],
  );

  const handleSubmit = useCallback(async () => {
    const response = await pssApi.createSequence({ data: sequence });
    if (response.ok) {
      Notification.success('app.api.generic.save.success.message');
      navigate('/pss/sequences');
    }
  }, [sequence]);

  const steps: StepsStepProps[] = [
    {
      title: 'Configuration',
      controls: <SequenceForm />,
      isFormItem: true,
    },
    {
      title: 'Scenarios',
      controls: <ScenarioSimpleForm />,
      isFormItem: true,
    },
  ];

  return (
    <GroupSequenceFormContext.Provider value={{ sequence, setSequence }}>
      <WizardPage
        wizard={{ title: 'app.page.home.newSequence' }}
        steps={steps}
        onNext={handleNext}
        onFinish={handleSubmit}
      />
    </GroupSequenceFormContext.Provider>
  );
};

export default withPage(SequenceFormPage);
