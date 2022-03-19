import React, { useCallback } from 'react';

import { Form, Notification, usePage, Widget, withComponent } from '@sms/plasma-ui';

import PlanningHorizonForm from '../../components/PlanningHorizonForm';
import { pssApi } from '../../services';
import { PlanningHorizonTypes } from '../../types';

// import { Container } from './styles';

interface Props {
  refetchPlanningHorizonList?: () => Promise<void>;
}

const PlanningHorizonGeneralView: React.FC<Props> = ({ refetchPlanningHorizonList }) => {
  const { masterItem } = usePage('masterItem');
  const item = masterItem as PlanningHorizonTypes.PlanningHorizon;

  const handleSubmit = useCallback(
    async (data: PlanningHorizonTypes.PlanningHorizon) => {
      if (data && data !== null) {
        const { ok } = await pssApi.updatePlanningHorizon({ data: { ...data, id: item.id } });

        if (ok) {
          if (refetchPlanningHorizonList) {
            refetchPlanningHorizonList();
          }
          Notification.success('app.api.generic.save.success.message');
        }
      }
    },
    [item, refetchPlanningHorizonList],
  );

  return (
    <Widget>
      <Form initialValues={item} onSubmit={handleSubmit} maxWidth="100%" showSave>
        <PlanningHorizonForm initialValues={item} />
      </Form>
    </Widget>
  );
};

export default withComponent(PlanningHorizonGeneralView);
