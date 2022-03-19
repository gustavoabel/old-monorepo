import React, { useEffect, useState, useCallback } from 'react';

import { Button } from '@sms/plasma-ui';

import { pssApi } from '../../../services';
import CodeInput from '../../CodeInput';

interface Props {
  code?: string;
  onCodeChanged: (code: string) => void;
  onSubmit?: () => void;
  isCodeValidInitialState?: boolean;
  materialTypeId?: number | string;
}

const comments = `/**
 * ----- Helper Functions -----
 * -> ValidateSlabGradeTransition: Function that retrieve the classification of the transition between Slab's Steel Grade.
 *
 * ----------------------------------------------------------------------------------------------------------------------------------
 *
 * ----- Scheduling Rule Function Context -----
 * -> currentLine: Current line which the rule will be applied
 * -> nextLine: Next line in the production sequence which the rule will be applied (Available depending on the Material Type)
 * Return => True: If violate any rule | False: Everything is OK
 */

`;

const defaultValue = `${comments}

function schedulingRule(context: Context): boolean {
  /*your code goes here*/
}
`;

const SchedulingRuleCodeForm: React.FC<Props> = ({
  code,
  onCodeChanged,
  onSubmit,
  isCodeValidInitialState,
  materialTypeId,
}) => {
  const [isButtonEnabled, setIsButtonEnabled] = useState<boolean | undefined>(false);
  const [isCodeValid, setIsCodeValid] = useState<boolean | undefined>(isCodeValidInitialState);
  const [libSource, setLibSource] = useState<string>();
  const [editableCode, setEditableCode] = useState<string>('');

  useEffect(() => {
    if (isCodeValidInitialState !== undefined) {
      setIsCodeValid(isCodeValidInitialState);
    }
  }, [isCodeValidInitialState]);

  useEffect(() => {
    if (code) {
      if (editableCode === '') setEditableCode(`${comments}${code}`);
    } else {
      if (editableCode === '') setEditableCode(defaultValue);
    }
  }, [code, editableCode]);

  const getCodeModelByMaterialType = useCallback(async (value) => {
    if (value && value !== null) {
      const { data: codeModel } = await pssApi.getSchedulingRuleModel({
        params: { materialTypeId: value },
      });

      setLibSource(codeModel);
    }
  }, []);

  useEffect(() => {
    getCodeModelByMaterialType(materialTypeId);
  }, [getCodeModelByMaterialType, materialTypeId]);

  const onButtonCliked = () => {
    if (onSubmit) {
      onSubmit();
    }
    setIsButtonEnabled(false);
  };

  const onCodeValidate = (isValid: boolean) => {
    setIsCodeValid(isValid);
  };

  const onChanged = (code: string) => {
    onCodeChanged(code);

    if (isCodeValid) {
      setIsButtonEnabled(true);
    }
  };

  return (
    <>
      <CodeInput
        OnChange={(code) => onChanged(code)}
        OnValidate={(isValid) => onCodeValidate(isValid)}
        value={editableCode}
        libSource={libSource ? libSource : ''}
        defaultValue={defaultValue}
      />
      {onSubmit ? <Button.Save disabled={!isButtonEnabled || !isCodeValid} onClick={onButtonCliked} /> : null}
    </>
  );
};

export default SchedulingRuleCodeForm;
