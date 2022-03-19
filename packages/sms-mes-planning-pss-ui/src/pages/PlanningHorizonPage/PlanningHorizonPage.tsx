import React, { useMemo } from 'react';

import {
  BasicMasterItem,
  Button,
  DataTableSearch,
  GridView,
  HeaderProps,
  Master,
  MasterDetailPage,
  Secure,
  useDataSource,
  withPage,
} from '@sms/plasma-ui';

import { pssApi } from '../../services';
import { PlanningHorizonTypes } from '../../types';
import PlanningHorizonGeneralView from './GeneralView';

function PlanningHorizonPage() {
  const { data: planningHorizonList, refetch: refetchPlanningHorizonList } = useDataSource(
    pssApi.getAllPlanningHorizon,
    [],
  );

  const master = useMemo(
    () => (
      <Master
        dataTree
        dataTreeChildField="children"
        dataTreeStartExpanded
        dataSource={planningHorizonList}
        renderItem={(item: PlanningHorizonTypes.PlanningHorizon) => (
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
    [planningHorizonList],
  );

  const header: Omit<HeaderProps<unknown>, 'enableGoBack'> = {
    deleteAction: (id: string | number) => pssApi.deletePlanningHorizon({ params: { id } }),
    deletePermissions: [],
  };

  return (
    <MasterDetailPage master={master} header={header}>
      <GridView id="general" title="app.common.general">
        <PlanningHorizonGeneralView refetchPlanningHorizonList={refetchPlanningHorizonList} />
      </GridView>
    </MasterDetailPage>
  );
}

export default withPage(PlanningHorizonPage, true);
