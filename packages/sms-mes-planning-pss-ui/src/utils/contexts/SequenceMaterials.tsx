import React, { createContext, useCallback, useState } from 'react';

import { pssApi } from '../../services';
import { DynamicObject } from '../../types/DynamicObject';
import { UnitSequenceMaterialList } from '../../types/UnitSequence';

type SequenceMaterialsContextType = {
  updateMaterialList: boolean;
  unitList: UnitSequenceMaterialList;
  handleMaterialSelection: (from?: DynamicObject, to?: DynamicObject) => void;
  setUpdateMaterialList: React.Dispatch<React.SetStateAction<boolean>>;
  getUnits: (id: number | string) => Promise<void>;
  selectedMaterials: { from?: DynamicObject; to?: DynamicObject };
};

interface Props {
  children: React.ReactNode;
}

export const SequenceMaterialsContext = createContext<SequenceMaterialsContextType>({
  updateMaterialList: false,
  unitList: {},
  handleMaterialSelection: () => {
    return;
  },
  setUpdateMaterialList: () => {
    return;
  },
  getUnits: () => new Promise(() => ({})),
  selectedMaterials: { from: undefined, to: undefined },
});

export function SequenceMaterialsProvider({ children }: Props) {
  const [updateMaterialList, setUpdateMaterialList] = useState<boolean>(false);
  const [unitList, setUnitList] = useState<UnitSequenceMaterialList>({});
  const [selectedMaterials, setSelectedMaterials] = useState<{ from?: DynamicObject; to?: DynamicObject }>({});

  const handleMaterialSelection = useCallback((from?: DynamicObject, to?: DynamicObject) => {
    setSelectedMaterials({ from, to });
  }, []);

  const getUnits = useCallback(async (id: number | string) => {
    const { data } = await pssApi.getScenarioMaterialList({ params: { sequenceScenarioId: id } });

    if (data) {
      setUnitList(data);
    }
  }, []);

  return (
    <>
      <SequenceMaterialsContext.Provider
        value={{
          updateMaterialList,
          handleMaterialSelection,
          unitList,
          setUpdateMaterialList,
          getUnits,
          selectedMaterials,
        }}
      >
        {children}
      </SequenceMaterialsContext.Provider>
    </>
  );
}
