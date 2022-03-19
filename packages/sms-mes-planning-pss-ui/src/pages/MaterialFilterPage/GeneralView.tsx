import React, { useCallback, useState, useEffect } from 'react';

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

import MaterialFilterFormFilter from '../../components/MaterialFilterForm/Filter';
import MaterialFilterFormGeneral from '../../components/MaterialFilterForm/General';
import { pssApi } from '../../services';
import { MaterialFilterTypes } from '../../types';
import { MaterialFilterContext } from '../../utils/contexts/materialFilterContext';

interface Props {
  refetchMaterialFilterList?: () => Promise<void>;
  master: React.ReactNode;
  header: Omit<HeaderProps<unknown>, 'enableGoBack'>;
}

const MaterialFilterGeneralView: React.FC<Props> = ({ refetchMaterialFilterList, master, header }) => {
  const { masterItem } = usePage('masterItem');
  const item = masterItem as MaterialFilterTypes.MaterialFilter;
  const [materialFilter, setMaterialFilter] = useState<MaterialFilterTypes.MaterialFilter>(item);
  const [newInitialValues, setNewInitialValues] = useState<MaterialFilterTypes.MaterialFilter>();

  useEffect(() => {
    setMaterialFilter(item);
  }, [item]);

  const handleSubmit = useCallback(
    async (data: MaterialFilterTypes.MaterialFilter) => {
      if (data && data !== null) {
        const { ok } = await pssApi.updateMaterialFilter({
          data: { ...data, id: item.id, expression: materialFilter.expression },
        });

        if (ok) {
          if (refetchMaterialFilterList) {
            refetchMaterialFilterList();
          }
          Notification.success('app.api.generic.save.success.message');
        }
      }
    },
    [item, materialFilter, refetchMaterialFilterList],
  );

  return (
    <MaterialFilterContext.Provider value={{ materialFilter, setMaterialFilter }}>
      <MasterDetailPage master={master} header={header}>
        <GridView id="general" title="app.common.general">
          <Widget>
            <Form initialValues={newInitialValues || materialFilter}>
              <MaterialFilterFormGeneral
                initialValues={materialFilter}
                setNewInitialValues={setNewInitialValues}
                handleSubmit={() => handleSubmit(materialFilter)}
              />
            </Form>
          </Widget>
        </GridView>
        <GridView id="filter" title="app.common.filter">
          <MaterialFilterFormFilter handleSubmit={() => handleSubmit(materialFilter)} />
        </GridView>
      </MasterDetailPage>
    </MaterialFilterContext.Provider>
  );
};

export default withComponent(MaterialFilterGeneralView);
