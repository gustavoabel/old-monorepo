import { useContext } from 'react';

import { KPIContext } from '../contexts';

const useKPI = () => useContext(KPIContext);

export default useKPI;
