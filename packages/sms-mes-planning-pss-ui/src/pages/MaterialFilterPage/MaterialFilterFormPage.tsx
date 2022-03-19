import React, { useCallback, useState } from 'react';

import { navigate, Notification, withPage, WizardPage } from '@sms/plasma-ui';

import MaterialFilterFormFilter from '../../components/MaterialFilterForm/Filter';
import MaterialFilterFormGeneral from '../../components/MaterialFilterForm/General';
import { pssApi } from '../../services';
import { MaterialFilterTypes } from '../../types';
import { MaterialFilterContext } from '../../utils/contexts/materialFilterContext';

const MaterialFilterFormPage: React.FC = () => {
  const [materialFilter, setMaterialFilter] = useState<MaterialFilterTypes.MaterialFilter>();
  const [initialValues, setInitialValues] = useState<Record<string, unknown>>();

  const handleSubmit = useCallback(
    async (data: MaterialFilterTypes.MaterialFilter) => {
      if (data && data !== null && materialFilter && materialFilter !== undefined) {
        const response = await pssApi.createMaterialFilter({
          data: { ...data, expression: materialFilter.expression },
        });

        if (response.ok) {
          Notification.success('app.api.generic.save.success.message');
          navigate('/pss/materialFilter');
        }
      }
    },
    [materialFilter],
  );

  return (
    <MaterialFilterContext.Provider value={{ materialFilter, setMaterialFilter }}>
      <WizardPage
        steps={[
          {
            title: 'app.common.general',
            controls: (
              <MaterialFilterFormGeneral initialValues={initialValues} setNewInitialValues={setInitialValues} />
            ),
            isFormItem: true,
          },
          { title: 'app.common.filter', controls: <MaterialFilterFormFilter /> },
        ]}
        wizard={{ title: 'Create new material filter' }}
        values={initialValues}
        onNext={(next) => setMaterialFilter({ ...materialFilter, ...(next as MaterialFilterTypes.MaterialFilter) })}
        onPrevious={() => setInitialValues(materialFilter)}
        onFinish={() => {
          if (materialFilter) {
            handleSubmit(materialFilter);
          }
        }}
      />
    </MaterialFilterContext.Provider>
  );
};

export default withPage(MaterialFilterFormPage);
