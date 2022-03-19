import { useContext } from 'react';

import { SequenceScenarioContext } from '../contexts';

const useSequenceScenario = () => useContext(SequenceScenarioContext);

export default useSequenceScenario;
