import React, { useMemo } from 'react';

import {
  BasicMasterItem,
  Button,
  DataTableSearch,
  Master,
  Secure,
  // useTranslation,
  withPage,
  useDataSource,
} from '@sms/plasma-ui';

import { pssApi } from '../../services';
import { ProgramTypeTypes } from '../../types';
import MaterialFilterGeneralView from './GeneralView';

function ProgramTypePage() {
  // const { t } = useTranslation();
  const { data: materialFilterList, refetch: refetchMaterialFilterList } = useDataSource(
    pssApi.getAllMaterialFilter,
    [],
  );

  const master = useMemo(
    () => (
      <Master
        dataTree
        dataTreeChildField="children"
        dataTreeStartExpanded
        dataSource={materialFilterList}
        renderItem={(item: ProgramTypeTypes.MasterDetailItem) => (
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
    [materialFilterList],
  );

  const header = {
    deleteAction: (id: string | number) => pssApi.deleteMaterialFilter({ params: { id } }),
    deletePermissions: [],
    subtitle: '',
  };

  return (
    <MaterialFilterGeneralView master={master} header={header} refetchMaterialFilterList={refetchMaterialFilterList} />
  );
}

export default withPage(ProgramTypePage, true);
