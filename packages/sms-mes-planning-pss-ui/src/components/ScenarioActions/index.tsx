import React, { useCallback } from 'react';

import { Icon, Modal, Notification, TranslatedText, usePage } from '@sms/plasma-ui';

import { pssApi } from '../../services';
import { SequenceScenario } from '../../types/SequenceScenario';
import { useModalForm, useSequenceMaterials, useSequenceScenario } from '../../utils/hooks';
import { StyledButton } from './styles';

export type ScenarioAction = {
  title: string;
  icon: string;
  canDisable: boolean;
  handleClick: () => void;
};

const ScenarioActions = (): React.ReactNode[] => {
  const { itemId } = usePage('itemId');

  const { openActionModal } = useModalForm();
  const { selectedSequence } = useSequenceScenario();
  const { selectedMaterials, getUnits } = useSequenceMaterials();
  const { masterItem } = usePage('masterItem');
  const Item = masterItem as SequenceScenario;

  const Actions: ScenarioAction[] = [
    {
      title: 'Add Material',
      icon: 'plus',
      canDisable: false,
      handleClick: () => {
        openActionModal({
          action: 'ADD_MATERIALS',
          data: {
            item: {
              sequence: selectedSequence,
              scenario: Item,
            },
          },
        });
        return;
      },
    },
    {
      title: 'Replace Material',
      icon: 'retweet',
      canDisable: true,
      handleClick: () => {
        return;
      },
    },
    {
      title: 'Delete Material',
      icon: 'trash-alt',
      canDisable: true,
      handleClick: () => {
        if (!selectedMaterials.from) {
          Notification.warning('Select a material');
          return;
        }
        Modal.confirm({
          title: <TranslatedText textKey="ui.confirmation.delete.title" />,
          icon: <Icon name="info-circle" />,
          cancelText: <TranslatedText textKey="ui.commons.cancel" />,
          onOk: async () => {
            const response = await pssApi.deleteMaterial({
              data: {
                materialId: Number(selectedMaterials.from?.material_id),
                sequenceItemId: Number(selectedMaterials.from?.sequenceItemId),
                sequenceScenarioId: Number(Item?.id),
              },
            });
            if (response.ok && itemId) {
              Notification.success('ui.generic.delete.success.message');
              getUnits(itemId);
            }
          },
        });
      },
    },
    {
      title: 'Accept rule violation',
      icon: 'check',
      canDisable: true,
      handleClick: () => {
        openActionModal({
          action: 'ACCEPT_VIOLATION_RULE',
          data: {
            item: {
              sequence: selectedSequence,
              scenario: Item,
            },
          },
        });
        return;
      },
    },
    {
      title: 'Change caster',
      icon: 'exchange',
      canDisable: true,
      handleClick: () => {
        return;
      },
    },
  ];

  const ActionButton = useCallback(
    ({ icon, handleClick, title, canDisable }: ScenarioAction): React.ReactNode => {
      return (
        <StyledButton
          disabled={selectedMaterials.from || !canDisable ? false : true}
          type="link"
          icon={<Icon name={icon} />}
          title={title}
          onClick={handleClick}
        />
      );
    },
    [selectedMaterials.from],
  );

  return Actions.map((action) => ActionButton(action));
};

export default ScenarioActions;
