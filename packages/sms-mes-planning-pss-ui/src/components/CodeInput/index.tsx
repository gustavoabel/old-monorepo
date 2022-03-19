import React, { useEffect, useState, useCallback } from 'react';

import Editor, { useMonaco } from '@monaco-editor/react';

import { CodeInputTypes } from '../../types';
import { CodeInputContainer } from './styles';

interface Props {
  OnChange: (code: string) => void;
  OnValidate: (isValid: boolean) => void;
  value: string;
  libSource: string;
  defaultValue?: string;
}

const CodeInput: React.FC<Props> = ({ OnChange, OnValidate, value, libSource, defaultValue }) => {
  const monaco = useMonaco();
  const [modelId, setModelId] = useState<string>();
  const [currentLibSource, setCurrentLibSource] = useState<string>(libSource);

  useEffect(() => {
    if (libSource && libSource !== currentLibSource) {
      setCurrentLibSource(libSource);
    }
  }, [libSource, currentLibSource]);

  const createNewModel = useCallback(
    (editor: CodeInputTypes.Editor) => {
      const newModel = editor.createModel(libSource, 'typescript');

      if (newModel.id !== modelId) {
        setModelId(newModel.id);
      }
    },
    [modelId, libSource],
  );

  const removeCurrentModel = useCallback(
    (editor: CodeInputTypes.Editor) => {
      const models = editor.getModels();

      models.forEach((model: CodeInputTypes.Model, index: number) => {
        if (modelId && index !== models.length - 1) {
          model.dispose();
        }
      });
    },
    [modelId],
  );

  useEffect(() => {
    if (monaco) {
      const { editor } = monaco;
      if (modelId === undefined) {
        createNewModel(editor);
      }
    }
  }, [monaco, modelId, createNewModel]);

  useEffect(() => {
    if (monaco && currentLibSource !== libSource) {
      const { editor } = monaco;
      removeCurrentModel(editor);
      createNewModel(editor);
    }
  }, [monaco, currentLibSource, libSource, createNewModel, removeCurrentModel]);

  const isCodeValid = (markers: Record<string, string>[]) => {
    const isCodeValid = markers && markers.length === 0;
    OnValidate(isCodeValid);
  };

  return (
    <CodeInputContainer>
      <Editor
        height="calc(100vh - 310px)"
        language="typescript"
        theme="vs-dark"
        defaultValue={defaultValue}
        onChange={(value) => OnChange(value ?? '')}
        onValidate={(markers) => isCodeValid(markers)}
        value={value}
      />
    </CodeInputContainer>
  );
};

export default CodeInput;
