import { useContext } from 'react';

import { ModalFormContext } from '../contexts';

const useModalForm = () => useContext(ModalFormContext);

export default useModalForm;
