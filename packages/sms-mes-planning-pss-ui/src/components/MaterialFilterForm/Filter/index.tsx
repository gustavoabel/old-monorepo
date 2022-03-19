import React, { useCallback, useEffect, useState } from 'react';
import {
  Query,
  Builder,
  Utils as QbUtils,
  JsonGroup,
  Config,
  ImmutableTree,
  BuilderProps,
  FieldOrGroup,
  JsonLogicTree,
} from 'react-awesome-query-builder';
import AntdConfig from 'react-awesome-query-builder/lib/config/antd';

import 'react-awesome-query-builder/lib/css/styles.css';
import { Widget, Button } from '@sms/plasma-ui';

import { pssApi } from '../../../services';
import { MaterialAttributeTypes, MaterialFilterTypes } from '../../../types';
import { useMaterialFilter } from '../../../utils/contexts/materialFilterContext';
import { CustomBuilderContainer, ButtonContainer } from './styles';

const initialConfig: Config = {
  ...AntdConfig,
};

const queryValue: JsonGroup = { id: QbUtils.uuid(), type: 'group' };

const initialTree: ImmutableTree = QbUtils.checkTree(QbUtils.loadTree(queryValue), initialConfig);

const initialState = {
  tree: initialTree,
  config: initialConfig,
};

interface Props {
  handleSubmit?: () => Promise<void>;
}

const MaterialFilterFormFilter: React.FC<Props> = ({ handleSubmit }) => {
  const { materialFilter, setMaterialFilter } = useMaterialFilter();
  const [state, setState] = useState(initialState);
  const [isSaveEnabled, setIsSaveEnabled] = useState(false);

  const getConfigByMaterialAttribute = useCallback(
    (materialAttribute: MaterialAttributeTypes.MaterialAttribute[]) => {
      const configFields = materialAttribute.reduce<{ [key: string]: FieldOrGroup }>((acc, cur) => {
        acc[cur.id] = {
          label: cur.name.replaceAll('_', ' '),
          type: cur.type,
          valueSources: ['value'],
        };
        return acc;
      }, {});

      return {
        ...state.config,
        fields: configFields,
      };
    },
    [state.config],
  );

  const getAttributesByUnitGroup = async (value: MaterialFilterTypes.MaterialFilter) => {
    const { data: materialAttribute } = await pssApi.getMaterialFilterOptions({
      params: { productionUnitGroupId: Number(value.productionUnitGroupId) },
    });

    if (materialAttribute) {
      const newConfig: Config = getConfigByMaterialAttribute(materialAttribute);
      const newTree: ImmutableTree = getTreeByInitialValue(newConfig, value);
      setState({ tree: newTree, config: newConfig });
    } else {
      setState(initialState);
    }
  };

  useEffect(() => {
    if (materialFilter) {
      getAttributesByUnitGroup(materialFilter);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [materialFilter?.id]);

  const onChange = (immutableTree: ImmutableTree, config: Config) => {
    const jsonExpression = JSON.stringify(QbUtils.jsonLogicFormat(immutableTree, config).logic);
    if (jsonExpression !== undefined && jsonExpression !== materialFilter?.expression) {
      setIsSaveEnabled(true);
    }

    const newMaterialFilter = { ...materialFilter, expression: jsonExpression };
    if (newMaterialFilter && setMaterialFilter) {
      setMaterialFilter(newMaterialFilter as MaterialFilterTypes.MaterialFilter);
    }
    setState({ tree: immutableTree, config });
  };

  const getTreeByInitialValue = (config: Config, materialFilter?: MaterialFilterTypes.MaterialFilter) => {
    if (materialFilter && materialFilter.expression !== undefined) {
      const newExpression: JsonLogicTree = JSON.parse(materialFilter.expression);
      return QbUtils.checkTree(QbUtils.loadFromJsonLogic(newExpression, config), config);
    } else {
      return initialTree;
    }
  };

  const renderBuilder = (props: BuilderProps) => (
    <div className="query-builder">
      <CustomBuilderContainer>
        <Builder {...props} />
      </CustomBuilderContainer>
    </div>
  );

  const onSave = () => {
    if (handleSubmit) {
      handleSubmit();
    }
    setIsSaveEnabled(false);
  };

  return (
    <Widget>
      {handleSubmit && (
        <ButtonContainer>
          <Button.Save disabled={!isSaveEnabled} onClick={onSave} />
        </ButtonContainer>
      )}
      {state.config.fields ? (
        <Query {...state.config} value={state.tree} onChange={onChange} renderBuilder={renderBuilder} />
      ) : null}
    </Widget>
  );
};

export default MaterialFilterFormFilter;
