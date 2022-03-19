import { useContext } from 'react';

import { GroupSequenceFormContext } from '../contexts';

const useSequenceForm = () => useContext(GroupSequenceFormContext);

export default useSequenceForm;
