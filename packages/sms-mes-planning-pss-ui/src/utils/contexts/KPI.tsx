import React, { createContext, useCallback, useState } from 'react';

import { pssApi } from '../../services';
import { KPIView } from '../../types/KPI';

type KPIContextType = {
  kpiList: KPIView[] | null;
  getKpiList: (sequenceScenarioId: string | number) => void;
};

interface Props {
  children: React.ReactNode;
}

export const KPIContext = createContext<KPIContextType>({
  kpiList: null,
  getKpiList: () => {
    return;
  },
});

export function KPIProvider({ children }: Props) {
  const [kpiList, setKpiList] = useState<KPIView[] | null>(null);

  const getKpiList = useCallback(async (sequenceScenarioId) => {
    if (sequenceScenarioId !== null && sequenceScenarioId > 0) {
      const { data } = await pssApi.getKPIList({ data: { sequenceScenarioId } });
      setKpiList(data || null);
    }
  }, []);

  return (
    <>
      <KPIContext.Provider
        value={{
          kpiList,
          getKpiList,
        }}
      >
        {children}
      </KPIContext.Provider>
    </>
  );
}
