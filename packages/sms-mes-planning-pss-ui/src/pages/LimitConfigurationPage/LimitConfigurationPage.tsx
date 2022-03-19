import React, { useMemo } from 'react';

import {
  BasicMasterItem,
  DataTableSearch,
  GridView,
  HeaderProps,
  Master,
  MasterDetailPage,
  useDataSource,
  withPage,
} from '@sms/plasma-ui';

import { pssApi } from '../../services';
import { LimitConfigurationTypes } from '../../types';
import LimitConfigurationGeneralView from './GeneralView';

function LimitConfigurationPage() {
  const { data: limitConfigurationList, refetch: refetchLimitConfigurationList } = useDataSource(
    pssApi.getAllLimitConfiguration,
    [],
  );

  const master = useMemo(
    () => (
      <Master
        dataTree
        dataTreeChildField="children"
        dataTreeStartExpanded
        dataSource={limitConfigurationList}
        renderItem={(item: LimitConfigurationTypes.LimitConfiguration) => (
          <BasicMasterItem key={item.id} title={item.name} icon="editing-orthogonal_view" />
        )}
        toolbar={{
          title: 'app.page.limitConfiguration.productionUnits',
          search: <DataTableSearch fields={['name']} />,
        }}
      />
    ),
    [limitConfigurationList],
  );

  const header: Omit<HeaderProps<unknown>, 'enableGoBack'> = {};

  return (
    <MasterDetailPage master={master} header={header}>
      <GridView id="general" title="app.common.general">
        <LimitConfigurationGeneralView refetchLimitConfigurationList={refetchLimitConfigurationList} />
      </GridView>
    </MasterDetailPage>
  );
}

export default withPage(LimitConfigurationPage, true);
