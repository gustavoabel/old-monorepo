import React, { useMemo } from 'react';

import { Modal, withComponent } from '@sms/plasma-ui';

import { useModalForm } from '../..';
import AcceptViolationRuleForm from '../AcceptViolationRuleForm';
import AddMaterialsForm from '../AddMaterialsForm';
import AddScenarioForm from '../AddScenarioForm';
import EditSequenceForm from '../EditSequenceForm';

const ModalForm: React.FC = () => {
  const { visible, loading, modalType, modalData } = useModalForm();

  const ModalBody = useMemo(() => {
    switch (modalType) {
      case 'ACCEPT_VIOLATION_RULE':
        return <AcceptViolationRuleForm item={modalData.item} />;

      case 'ADD_MATERIALS':
        return <AddMaterialsForm item={modalData.item} />;

      case 'ADD_SCENARIO':
        return <AddScenarioForm item={modalData.item} />;

      case 'EDIT_SCENARIO':
        return <AddScenarioForm item={modalData.item} isEdit />;

      case 'EDIT_SEQUENCE':
        return <EditSequenceForm item={modalData.item} />;

      case 'REPLACE_MATERIALS':
        return <AddMaterialsForm item={modalData.item} />;

      case 'CHANGE_CASTER':
        return <AddMaterialsForm item={modalData.item} />;

      case 'DELETE_MATERIALS':
        return <AddMaterialsForm item={modalData.item} />;

      default:
        return null;
    }
  }, [modalData, modalType]);

  return (
    <Modal
      visible={visible}
      confirmLoading={loading}
      width="80vw"
      centered
      closable={false}
      destroyOnClose
      footer={null}
    >
      {ModalBody}
    </Modal>
  );
};

export default withComponent(ModalForm);
