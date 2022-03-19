import React, { useMemo } from 'react';

import {
  BasicMasterItem,
  Button,
  DataTableSearch,
  HeaderProps,
  Master,
  Secure,
  useDataSource,
  withPage,
} from '@sms/plasma-ui';

import { pssApi } from '../../services';
import { SchedulingRuleTypes } from '../../types';
import SchedulingRuleGeneralView from './GeneralView';

function SchedulingRulePage() {
  const { data: schedulingRuleList, refetch: refetchSchedulingRuleList } = useDataSource(
    pssApi.getAllSchedulingRule,
    [],
  );

  const master = useMemo(
    () => (
      <Master
        dataTree
        dataTreeChildField="children"
        dataTreeStartExpanded
        dataSource={schedulingRuleList}
        renderItem={(item: SchedulingRuleTypes.SchedulingRule) => (
          <BasicMasterItem key={item.id} title={item.name} icon="editing-orthogonal_view" />
        )}
        toolbar={{
          title: 'app.common.allItems',
          search: <DataTableSearch fields={['name']} />,
          actions: [
            <Secure key="new" permissions={[]}>
              <Button.New navigationPath="/create" relativeNavigation />
            </Secure>,
          ],
        }}
      />
    ),
    [schedulingRuleList],
  );

  const header: Omit<HeaderProps<unknown>, 'enableGoBack'> = {
    deleteAction: (id: string | number) => pssApi.deleteSchedulingRule({ params: { id } }),
    deletePermissions: [],
  };

  return (
    <SchedulingRuleGeneralView master={master} header={header} refetchSchedulingRuleList={refetchSchedulingRuleList} />
  );
}

export default withPage(SchedulingRulePage, true);
