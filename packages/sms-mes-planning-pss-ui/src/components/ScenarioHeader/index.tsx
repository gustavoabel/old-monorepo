import React, { useMemo } from 'react';

import {
  Button,
  Icon,
  Modal,
  Popover,
  usePage,
  withComponent,
  Notification,
  navigate,
  TranslatedText,
  Row,
} from '@sms/plasma-ui';

import { pssApi } from '../../services';
import { SequenceScenario } from '../../types/SequenceScenario';
import { useModalForm, useSequenceScenario } from '../../utils/hooks';
import { default as HeaderActions } from '../ScenarioActions';
import {
  Container,
  Content,
  EllipsisButton,
  ModalContainer,
  ModalText,
  ModalTitle,
  PopoverLink,
  Title,
} from './styles';

const ScenarioHeader: React.FC = () => {
  const { masterItem } = usePage('masterItem');
  const SelectedItem = masterItem as SequenceScenario;
  const { openActionModal } = useModalForm();
  const {
    selectedSequence,
    searchScenarioBySequence,
    refetchGroupSequenceList,
    setSelectedSequence,
    handleGroupSequence,
  } = useSequenceScenario();

  const bookGroupSequence = () => {
    Modal.confirm({
      content: (
        <ModalContainer>
          <Row>
            <ModalTitle>Book group sequence?</ModalTitle>
          </Row>
          <Row>
            <ModalText>
              You are booking <b>{selectedSequence?.name}</b> using scenario <b>{SelectedItem?.name}</b>.
            </ModalText>
          </Row>
        </ModalContainer>
      ),
      okText: 'Book',
      icon: null,
      onOk: async () => {
        if (selectedSequence?.id && SelectedItem?.id) {
          const { ok } = await pssApi.bookGroupSequence({
            params: { groupSequenceId: selectedSequence.id, sequenceScenarioId: SelectedItem.id },
          });

          if (ok) {
            Notification.success('app.api.generic.save.success.message');
            searchScenarioBySequence(selectedSequence.id);
            if (handleGroupSequence) {
              handleGroupSequence(selectedSequence.id);
            }
            return;
          }
        }

        return;
      },
    });
  };

  const sendToMES = () => {
    Modal.confirm({
      content: (
        <ModalContainer>
          <Row>
            <ModalTitle>Send group sequence to MES?</ModalTitle>
          </Row>
          <Row>
            <ModalText>
              You are sending <b>{selectedSequence?.name}</b> to MES using scenario <b>{SelectedItem?.name}</b>. You
              will not be able to make changes to this group sequence after that.
            </ModalText>
          </Row>
        </ModalContainer>
      ),
      okText: 'Send',
      icon: null,
      onOk: async () => {
        if (selectedSequence?.id && SelectedItem?.id) {
          const { ok } = await pssApi.saveToMesSequence({
            params: { groupSequenceId: selectedSequence.id },
          });

          if (ok) {
            Notification.success('app.api.generic.save.success.message');
            searchScenarioBySequence(selectedSequence.id);
            if (handleGroupSequence) {
              handleGroupSequence(selectedSequence.id);
            }
            return;
          }
        }

        return;
      },
    });
  };

  const ScenarioActions = useMemo(
    () => (
      <>
        <PopoverLink
          type="link"
          icon={<Icon name="edit" />}
          title="app.page.home.actions.editScenario"
          onClick={() => {
            return openActionModal({
              action: 'EDIT_SCENARIO',
              data: {
                item: {
                  sequence: selectedSequence,
                  scenario: SelectedItem,
                },
              },
            });
          }}
        />
        <PopoverLink
          type="link"
          icon={<Icon name="trash-alt" />}
          title="app.page.home.actions.deleteScenario"
          onClick={() =>
            Modal.confirm({
              title: <TranslatedText textKey="ui.generic.delete.question" />,
              icon: <Icon name="info-circle" />,
              onOk: async () => {
                const { ok } = await pssApi.deleteSequenceScenario({ params: { id: SelectedItem?.id } });
                if (ok && SelectedItem?.id) {
                  Notification.success('ui.generic.delete.success.message');
                  searchScenarioBySequence(selectedSequence?.id || 0);
                  setSelectedSequence(null);
                  if (refetchGroupSequenceList) {
                    refetchGroupSequenceList();
                  }
                  navigate('/pss/sequences');
                }
              },
            })
          }
        />
      </>
    ),
    [
      SelectedItem,
      openActionModal,
      refetchGroupSequenceList,
      searchScenarioBySequence,
      selectedSequence,
      setSelectedSequence,
    ],
  );

  return (
    <Container>
      <Content>
        <Title>{SelectedItem?.name}</Title>
        <Popover trigger="click" content={ScenarioActions} align={{ points: ['tc', 'bc'] }}>
          <EllipsisButton icon={<Icon name="ellipsis-v" />} type="link" />
        </Popover>
        <Button
          title="app.page.home.actions.newScenario"
          onClick={() => {
            return openActionModal({
              action: 'ADD_SCENARIO',
              data: {
                item: {
                  sequence: selectedSequence,
                  scenario: SelectedItem,
                },
              },
            });
          }}
        />

        {selectedSequence && selectedSequence.planningStatus !== 'SENT TO MES' ? (
          <>
            {SelectedItem?.selected ? (
              <Button title="Send To MES" type="primary" onClick={sendToMES} />
            ) : (
              <Button title="Book Group Sequence" type="primary" onClick={bookGroupSequence} />
            )}
          </>
        ) : (
          <></>
        )}
      </Content>
      <Content>{HeaderActions()}</Content>
    </Container>
  );
};

export default withComponent(ScenarioHeader);
