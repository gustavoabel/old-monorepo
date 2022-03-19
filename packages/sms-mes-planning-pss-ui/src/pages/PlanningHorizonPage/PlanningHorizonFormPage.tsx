import React, { useCallback } from 'react';

import { CreatePage, Notification, withPage } from '@sms/plasma-ui';

import PlanningHorizonForm from '../../components/PlanningHorizonForm';
import { pssApi } from '../../services';
import { PlanningHorizonTypes } from '../../types';

// import { Container } from './styles';

const PlanningHorizonFormPage: React.FC = () => {
  const handleSubmit = useCallback(async (data: PlanningHorizonTypes.PlanningHorizon) => {
    if (data && data !== null) {
      const response = await pssApi.createPlanningHorizon({ data });

      if (!response.ok) {
        Notification.error('app.api.generic.error.message');
      }
    }
  }, []);

  return (
    <CreatePage entity="app.page.planningHorizon" onSubmit={handleSubmit}>
      <PlanningHorizonForm />
    </CreatePage>
  );
};

export default withPage(PlanningHorizonFormPage);
