import React, { useEffect, useState } from 'react';

import { Row, Col, TextInput, Select, Switch, Button } from '@sms/plasma-ui';

import { pssApi } from '../../../services';
import { MaterialFilterTypes } from '../../../types';
import { useMaterialFilter } from '../../../utils/contexts/materialFilterContext';
import CounterCharacter from '../../CounterCharacter';

interface Props {
  initialValues?: Record<string, unknown>;
  setNewInitialValues: (values: MaterialFilterTypes.MaterialFilter) => void;
  handleSubmit?: () => Promise<void>;
}

const MaterialFilterFormGeneral: React.FC<Props> = ({ initialValues, setNewInitialValues, handleSubmit }) => {
  const { materialFilter, setMaterialFilter } = useMaterialFilter();
  const [initial, setInitial] = useState<MaterialFilterTypes.MaterialFilter>();

  useEffect(() => {
    if (initialValues && initialValues.id) {
      setNewInitialValues({
        id: Number(initialValues.id),
        productionUnitGroupId: String(initialValues.productionUnitGroupId),
        name: String(initialValues.name),
        description: initialValues.description ? String(initialValues.description) : '',
        expression: String(initialValues.expression),
        isDefault: Boolean(initialValues.isDefault),
      });
    }
  }, [initialValues, setNewInitialValues]);

  useEffect(() => {
    if (materialFilter && !initial) {
      setInitial(materialFilter);
    }
  }, [initial, materialFilter]);

  const onSave = () => {
    if (handleSubmit) {
      handleSubmit();
    }
    setInitial(materialFilter);
  };

  return (
    <>
      <Row gutter={24}>
        <Col span={12}>
          <Select
            label="app.forms.productionUnitGroup"
            name="productionUnitGroupId"
            dataSource={pssApi.getAllProductionUnitGroup}
            labelField="name"
            valueField={(item) => String(item.id)}
            onChange={(item) => {
              if (materialFilter && setMaterialFilter) {
                const newMaterialFilter = { ...materialFilter, productionUnitGroupId: Number(item) };
                setMaterialFilter(newMaterialFilter);
              }
            }}
          />
        </Col>
        <Col span={12}>
          <TextInput
            label="app.forms.name"
            name="name"
            onChange={(item) => {
              if (materialFilter && setMaterialFilter) {
                const newMaterialFilter = { ...materialFilter, name: item.target.value };
                setMaterialFilter(newMaterialFilter);
              }
            }}
          />
        </Col>
      </Row>
      <Row gutter={24}>
        <Col span={24}>
          <CounterCharacter
            name="description"
            description={initialValues?.description ? String(initialValues?.description) : ''}
            onChange={(item) => {
              if (materialFilter && setMaterialFilter) {
                const newMaterialFilter = { ...materialFilter, description: item.target.value };
                setMaterialFilter(newMaterialFilter);
              }
            }}
          />
        </Col>
      </Row>
      <Row gutter={24}>
        <Col span={24}>
          <Switch
            label="app.forms.defaultMaterialFilter"
            name="isDefault"
            onChange={(item) => {
              if (materialFilter && setMaterialFilter) {
                const newMaterialFilter = { ...materialFilter, isDefault: item };
                setMaterialFilter(newMaterialFilter);
              }
            }}
          />
        </Col>
      </Row>
      {initialValues && initial && materialFilter && (
        <Row style={{ marginTop: 16 }} justify="end" gutter={24}>
          <Col>
            <Button.Save disabled={initial === materialFilter} onClick={onSave} />
          </Col>
        </Row>
      )}
    </>
  );
};

export default MaterialFilterFormGeneral;
