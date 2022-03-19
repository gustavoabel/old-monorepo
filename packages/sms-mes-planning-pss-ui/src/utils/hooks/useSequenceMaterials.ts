import { useContext } from 'react';

import { SequenceMaterialsContext } from '../contexts';

const useSequenceMaterials = () => useContext(SequenceMaterialsContext);

export default useSequenceMaterials;
