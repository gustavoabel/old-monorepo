import React, { useCallback } from 'react';

import { Form, usePage, Widget, withComponent, Notification } from '@sms/plasma-ui';

import LimitConfigurationForm from '../../components/LimitConfigurationForm';
import { pssApi } from '../../services';
import { LimitConfigurationTypes } from '../../types';

interface Props {
  refetchLimitConfigurationList?: () => Promise<void>;
}

const LimitConfigurationGeneralView: React.FC<Props> = ({ refetchLimitConfigurationList }) => {
  const { masterItem } = usePage('masterItem');
  const item = masterItem as LimitConfigurationTypes.LimitConfiguration;

  const handleSubmit = useCallback(
    async (data: LimitConfigurationTypes.LimitConfiguration) => {
      if (data && data !== null) {
        const { ok } = await pssApi.updateLimitConfiguration({ data: { ...data, id: item.id } });

        if (ok) {
          if (refetchLimitConfigurationList) {
            refetchLimitConfigurationList();
          }
          Notification.success('app.api.generic.save.success.message');
        }
      }
    },
    [item, refetchLimitConfigurationList],
  );

  return (
    <Widget>
      <Form initialValues={item} onSubmit={handleSubmit} maxWidth="100%" showSave>
        <LimitConfigurationForm />
      </Form>
    </Widget>
  );
};

export default withComponent(LimitConfigurationGeneralView);
