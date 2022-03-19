import { createContext, useContext } from 'react';

import { MaterialFilterTypes } from '../../types';

type MaterialFilterContextType = {
  materialFilter?: MaterialFilterTypes.MaterialFilter;
  setMaterialFilter?: (materialFilter: MaterialFilterTypes.MaterialFilter) => void;
};

export const MaterialFilterContext = createContext<MaterialFilterContextType>({});
export const useMaterialFilter = () => useContext(MaterialFilterContext);
