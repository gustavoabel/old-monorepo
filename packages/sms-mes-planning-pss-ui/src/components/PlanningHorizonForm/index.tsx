import React, { ChangeEvent, useCallback, useEffect, useState } from 'react';

import { Row, Col, TextInput, TextArea, NumberInput, Select, Switch } from '@sms/plasma-ui';

import { pssApi } from '../../services';
import { MaterialAttributeTypes, PlanningHorizonTypes } from '../../types';
import CounterCharacter from '../CounterCharacter';
interface Props {
  initialValues?: PlanningHorizonTypes.PlanningHorizon;
}

const PlanningHorizonForm: React.FC<Props> = ({ initialValues }) => {

  const [attributesByUnitGroup, setAttributesByUnitGroup] = useState<MaterialAttributeTypes.MaterialAttribute[]>([]);

  const getAttributesByUnitGroup = useCallback(async (value) => {
    if (value && value !== null) {
      const { data: materialAttribute } = await pssApi.getMaterialAttributeByUnitGroup({
        params: { productionUnitGroupId: value },
      });

      if (materialAttribute) {
        setAttributesByUnitGroup(materialAttribute);
      } else {
        setAttributesByUnitGroup([]);
      }
    }
  }, []);

  useEffect(() => {
    if (initialValues) {
      getAttributesByUnitGroup(initialValues.productionUnitGroupId);
    }

    return () => {
      setAttributesByUnitGroup([]);
    };
  }, [initialValues, getAttributesByUnitGroup]);



  return (
    <>
      <Row gutter={24}>
        <Col span={12}>
          <Select
            label="app.forms.productionUnitGroup"
            name="productionUnitGroupId"
            dataSource={pssApi.getAllProductionUnitGroup}
            labelField="name"
            valueField="id"
            onChange={getAttributesByUnitGroup}
          />
        </Col>
        <Col span={12}>
          <TextInput label="app.forms.name" name="name" />
        </Col>
      </Row>
      <Row gutter={24}>
        <Col span={12}>
          <Select
            label="app.forms.attribute"
            name="materialAttributeDefinitionId"
            dataSource={attributesByUnitGroup}
            labelField={(item) => item.name.replaceAll("_", " ")}
            valueField="id"
          />
        </Col>
        <Col span={12}>
          <NumberInput label="app.forms.horizon" name="horizon" />
        </Col>
      </Row>
      <Row gutter={24}>
        <Col span={24}>
          <CounterCharacter name="description" description={initialValues?.description} />
        </Col>
      </Row>
      <Row gutter={24}>
        <Col span={24}>
          <Switch label="app.forms.defaultPlanningHorizon" name="isDefault" />
        </Col>
      </Row>
    </>
  );
};

export default PlanningHorizonForm;
