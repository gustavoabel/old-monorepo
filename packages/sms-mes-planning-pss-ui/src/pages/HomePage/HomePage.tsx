import React, { useCallback, useEffect, useMemo, useState } from 'react';

import {
  Col,
  Divider,
  GridView,
  HeaderProps,
  Icon,
  Master,
  MasterDetailPage,
  Modal,
  navigate,
  Popover,
  Select,
  useDataSource,
  withPage,
  Notification,
  TranslatedText,
  useRouter,
} from '@sms/plasma-ui';

import { MasterItem } from '../../components';
import KPIDisplay from '../../components/KPIDisplay';
import ModalForm from '../../components/ModalForm';
import ScenarioHeader from '../../components/ScenarioHeader';
import { pssApi } from '../../services';
import { GroupSequence } from '../../types/GroupSequence';
import { SequenceScenario } from '../../types/SequenceScenario';
import { DateFormatter, useModalForm, useSequenceMaterials } from '../../utils';
import { KPIProvider, SequenceScenarioContext } from '../../utils/contexts';
import SequenceGeneralView from './GeneralView';
import {
  Container,
  EllipsisButton,
  PopoverLink,
  SearchAreaContainer,
  SelectButtonContainer,
  StatusLabel,
  StatusSign,
  StyledRow,
} from './styles';

function HomePage() {
  const [scenarioList, setScenarioList] = useState<Partial<SequenceScenario>[]>([]);
  const [selectedSequence, setSelectedSequence] = useState<GroupSequence | null>(null);
  const [selectedScenario, setSelectedScenario] = useState<SequenceScenario | null | Partial<SequenceScenario>>(null);
  const [selectedMaterial, setSelectedMaterial] = useState(null);
  const { route } = useRouter('route');
  const { openActionModal } = useModalForm();
  const { handleMaterialSelection } = useSequenceMaterials();

  useEffect(() => {
    const { id } = route.params as Record<string, string>;
    if (id) {
      const findScenario = scenarioList.find((item) => item.id === Number(id));
      if (findScenario) {
        setSelectedScenario(findScenario);
      }
    }
  }, [route, scenarioList]);

  const searchScenarioBySequence = useCallback(async (id: number) => {
    const { data } = await pssApi.getScenariosForSequence({ params: { id } });

    if (data) setScenarioList(data);
    else setScenarioList([]);
  }, []);

  const handleGroupSequence = useCallback(
    async (value) => {
      let groupSequenceList: GroupSequence[] | undefined;

      await pssApi.getAllGroupSequence().then((result) => {
        groupSequenceList = result.data;
      });
      handleMaterialSelection();

      const sequence = groupSequenceList?.find((s) => s.id === value);
      if (sequence) setSelectedSequence(sequence);
      searchScenarioBySequence(value);
    },
    [handleMaterialSelection, searchScenarioBySequence],
  );

  const selectSequenceIfHasScenarioId = useCallback(
    async (scenarioId) => {
      try {
        const { data } = await pssApi.getSequenceByScenarioId({
          params: { scenarioId },
        });
        if (data) {
          setSelectedSequence(data);
          handleGroupSequence(data.id);
        } else {
          navigate('/pss/sequences');
        }
      } catch (error) {
        throw new Error(`Get By Scenario Id Failed: ${error}`);
      }
    },
    [handleGroupSequence],
  );

  useEffect(() => {
    const { id } = route.params as Record<string, string>;
    if (id) {
      selectSequenceIfHasScenarioId(id);
    }
  }, [route, selectSequenceIfHasScenarioId]);

  const { data: groupSequenceList, refetch: refetchGroupSequenceList } = useDataSource(
    async () => await pssApi.getAllGroupSequence(),
    [],
  );

  const SequenceActions = useMemo(
    () => (
      <>
        <PopoverLink
          type="link"
          icon={<Icon name="edit" />}
          title="app.page.home.actions.editSequence"
          onClick={() => {
            return openActionModal({
              action: 'EDIT_SEQUENCE',
              data: {
                item: {
                  sequence: selectedSequence,
                  scenario: selectedScenario,
                },
              },
            });
          }}
        />
        <PopoverLink
          type="link"
          icon={<Icon name="trash-alt" />}
          title="app.page.home.actions.deleteSequence"
          onClick={() =>
            Modal.confirm({
              title: <TranslatedText textKey="ui.generic.delete.question" />,
              icon: <Icon name="info-circle" />,
              onOk: async () => {
                const { ok } = await pssApi.deleteSequence({ params: { id: Number(selectedSequence?.id) } });
                if (ok && selectedSequence?.id) {
                  Notification.success('ui.generic.delete.success.message');
                  if (refetchGroupSequenceList) {
                    refetchGroupSequenceList();
                  }
                  setSelectedScenario(null);
                  setSelectedSequence(null);
                  setScenarioList([]);
                  navigate('/pss/sequences');
                }
              },
            })
          }
        />
      </>
    ),
    [openActionModal, refetchGroupSequenceList, selectedScenario, selectedSequence],
  );

  const master = useMemo(
    () => (
      <Master
        dataTree
        dataTreeChildField="children"
        dataTreeStartExpanded
        dataSource={scenarioList}
        renderItem={(item) => <MasterItem itemData={item} sequence={selectedSequence} />}
        toolbar={{
          actions: [
            <Popover key="PopoverActions" trigger="click" content={SequenceActions} align={{ points: ['tc', 'bc'] }}>
              {selectedSequence && <EllipsisButton icon={<Icon name="ellipsis-v" />} type="link" />}
            </Popover>,
          ],
          filter: (
            <Container>
              <Select
                name="groupSequenceId"
                valueField="id"
                labelField="name"
                placeholder="Select the Group Sequence"
                dataSource={groupSequenceList}
                value={selectedSequence?.id}
                onChange={handleGroupSequence}
                dropdownRender={(menu) => (
                  <div>
                    <SelectButtonContainer>
                      <PopoverLink
                        type="link"
                        icon={<Icon name="plus" />}
                        title="app.page.home.newSequence"
                        onClick={() => navigate('/pss/sequences/create')}
                      />
                    </SelectButtonContainer>
                    <Divider style={{ margin: '4px 0' }} />
                    {menu}
                  </div>
                )}
              />
            </Container>
          ),
          search: (
            <SearchAreaContainer>
              <StatusLabel>
                Status: <StatusSign status={selectedSequence?.planningStatus} /> {selectedSequence?.planningStatus}
              </StatusLabel>
              <StatusLabel>
                Start Time: {DateFormatter(selectedSequence ? `${selectedSequence.startDate}` : '')}
              </StatusLabel>
            </SearchAreaContainer>
          ),
        }}
      />
    ),
    [SequenceActions, groupSequenceList, handleGroupSequence, scenarioList, selectedSequence],
  );

  const header: Omit<HeaderProps<unknown>, 'enableGoBack'> = {
    title: <ScenarioHeader />,
  };

  return (
    <KPIProvider>
      <SequenceScenarioContext.Provider
        value={{
          selectedSequence,
          selectedScenario,
          selectedMaterial,
          setSelectedSequence,
          setSelectedScenario,
          setSelectedMaterial,
          searchScenarioBySequence,
          refetchGroupSequenceList,
          handleGroupSequence,
        }}
      >
        <MasterDetailPage
          master={master}
          header={
            selectedScenario?.isOptimized !== null && selectedScenario?.isOptimized === false ? undefined : header
          }
        >
          {selectedScenario?.isOptimized !== null && selectedScenario?.isOptimized === false ? (
            <></>
          ) : (
            <GridView id="sequences" title="app.page.home">
              <StyledRow>
                <Col span={24}>
                  <KPIDisplay />
                </Col>
                <Col span={24}>
                  <SequenceGeneralView />
                  <ModalForm />
                </Col>
              </StyledRow>
            </GridView>
          )}
        </MasterDetailPage>
      </SequenceScenarioContext.Provider>
    </KPIProvider>
  );
}

export default withPage(HomePage, true);
