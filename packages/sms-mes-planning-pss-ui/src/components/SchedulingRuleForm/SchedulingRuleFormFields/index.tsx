import React, { useCallback, useEffect, useState } from 'react';

import { Row, Col, TextInput, Select } from '@sms/plasma-ui';

import { pssApi } from '../../../services';
import { MaterialAttributeTypes, MaterialTypeTypes, SchedulingRuleTypes } from '../../../types';
import CounterCharacter from '../../CounterCharacter';

interface Props {
  initialValues?: Record<string, unknown>;
  onMaterialTypeChanged?: (value: number) => void;
  onSelectChange?: (values: Record<string, unknown>) => void;
  setNewInitialValues: (values: SchedulingRuleTypes.SchedulingRule) => void;
}

const SchedulingRuleFormFields: React.FC<Props> = ({
  initialValues,
  onMaterialTypeChanged,
  onSelectChange,
  setNewInitialValues,
}) => {
  const [materialTypeByUnit, setMaterialTypeByUnit] = useState<MaterialTypeTypes.MaterialType[]>([]);
  const [attributesByMaterialType, setAttributesByMaterialType] = useState<MaterialAttributeTypes.MaterialAttribute[]>(
    [],
  );

  const getMaterialTypeByUnit = useCallback(async (value) => {
    if (value && value !== null) {
      const { data: materialType } = await pssApi.getMaterialTypeByProductionUnitId({
        params: { productionUnitId: value },
      });

      if (materialType) {
        setMaterialTypeByUnit(materialType);
      } else {
        setMaterialTypeByUnit([]);
      }
    }
  }, []);

  const getAttributesByMaterialType = useCallback(
    async (value) => {
      if (value && value !== null) {
        const { data: materialAttribute } = await pssApi.getSchedulingRulesOptions({
          params: { materialTypeId: value },
        });

        if (materialAttribute) {
          setAttributesByMaterialType(materialAttribute);
        } else {
          setAttributesByMaterialType([]);
        }

        if (onMaterialTypeChanged && initialValues?.materialTypeId && initialValues.materialTypeId !== value) {
          onMaterialTypeChanged(value);
        }
      }
    },
    [initialValues?.materialTypeId, onMaterialTypeChanged],
  );

  useEffect(() => {
    if (initialValues && initialValues.id) {
      setNewInitialValues({
        id: Number(initialValues.id),
        implementation: String(initialValues.implementation),
        name: String(initialValues.name),
        remark: initialValues.remark ? String(initialValues.remark) : '',
        materialAttributeDefinitionId: String(initialValues.materialAttributeDefinitionId),
        materialTypeId: String(initialValues.materialTypeId),
        productionUnitId: String(initialValues.productionUnitId),
      });
    }
  }, [initialValues, setNewInitialValues]);

  useEffect(() => {
    if (initialValues?.productionUnitId) {
      getMaterialTypeByUnit(initialValues?.productionUnitId);
    }

    return () => {
      setMaterialTypeByUnit([]);
    };
  }, [initialValues?.productionUnitId, getMaterialTypeByUnit]);

  useEffect(() => {
    if (initialValues?.materialTypeId) {
      getAttributesByMaterialType(initialValues?.materialTypeId);
    }

    return () => {
      setAttributesByMaterialType([]);
    };
  }, [initialValues?.materialTypeId, getAttributesByMaterialType]);

  return (
    <>
      <Row gutter={24}>
        <Col span={12}>
          <TextInput label="app.forms.name" name="name" />
        </Col>
      </Row>
      <Row gutter={24}>
        <Col span={24}>
          <CounterCharacter name="remark" description={initialValues?.remark ? String(initialValues?.remark) : ''} />
        </Col>
      </Row>
      <Row gutter={24}>
        <Col span={24}>
          <Select
            label="app.forms.productionUnit"
            name="productionUnitId"
            dataSource={pssApi.getAllProductionUnit}
            onChange={(value) => {
              getMaterialTypeByUnit(value);

              if (onSelectChange) {
                onSelectChange({
                  materialTypeId: null,
                  materialAttributeDefinitionId: null,
                });
              }
            }}
            labelField="name"
            valueField={(item) => String(item.id)}
          />
        </Col>
      </Row>
      <Row gutter={24}>
        <Col span={24}>
          <Select
            label="app.forms.materialType"
            name="materialTypeId"
            dataSource={materialTypeByUnit}
            onChange={(value) => {
              getAttributesByMaterialType(value);

              if (onSelectChange) {
                onSelectChange({
                  materialTypeId: value,
                  materialAttributeDefinitionId: null,
                });
              }
            }}
            labelField="name"
            valueField={(item) => String(item.id)}
          />
        </Col>
      </Row>
      <Row gutter={24}>
        <Col span={24}>
          <Select
            showSearch
            label="app.forms.attribute"
            name="materialAttributeDefinitionId"
            dataSource={attributesByMaterialType}
            valueField={(item) => String(item.id)}
            labelField={(item) => item.name.replaceAll('_', ' ')}
          />
        </Col>
      </Row>
    </>
  );
};

export default SchedulingRuleFormFields;
