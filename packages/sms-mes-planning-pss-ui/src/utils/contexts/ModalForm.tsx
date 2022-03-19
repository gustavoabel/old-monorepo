/* eslint-disable @typescript-eslint/no-explicit-any */
import React, { createContext, useCallback, useState } from 'react';

type ModalFormType =
  | 'ADD_MATERIALS'
  | 'ACCEPT_VIOLATION_RULE'
  | 'ADD_SCENARIO'
  | 'REPLACE_MATERIALS'
  | 'DELETE_MATERIALS'
  | 'CHANGE_CASTER'
  | 'EDIT_SCENARIO'
  | 'EDIT_SEQUENCE';

type ModalActionsEnabled = {
  action: ModalFormType;
  data: { item: Record<any, unknown> };
};

type ModalFormContextType = {
  visible: boolean;
  loading: boolean;
  modalType: ModalFormType | null;
  modalData: { item: Record<any, unknown> };
  setVisible: React.Dispatch<React.SetStateAction<boolean>>;
  setLoading: React.Dispatch<React.SetStateAction<boolean>>;
  openActionModal: (props: ModalActionsEnabled) => void;
};

interface Props {
  children: React.ReactNode;
}

export const ModalFormContext = createContext<ModalFormContextType>({
  visible: false,
  loading: false,
  modalType: null,
  modalData: { item: {} },
  openActionModal: () => {
    return;
  },
  setVisible: () => {
    return;
  },
  setLoading: () => {
    return;
  },
});

export function ModalFormProvider({ children }: Props) {
  const [visible, setVisible] = useState(false);
  const [loading, setLoading] = useState(false);
  const [modalType, setModalType] = useState<ModalFormType | null>(null);
  const [modalData, setModalData] = useState<{ item: Record<any, unknown> }>({ item: {} });

  const openActionModal = useCallback(({ action, data }: ModalActionsEnabled) => {
    setModalType(action);
    setModalData(data);
    setVisible(true);
    return;
  }, []);

  return (
    <>
      <ModalFormContext.Provider
        value={{
          visible,
          loading,
          modalType,
          modalData,
          openActionModal,
          setLoading,
          setVisible,
        }}
      >
        {children}
      </ModalFormContext.Provider>
    </>
  );
}
