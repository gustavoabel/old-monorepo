import React from 'react';

import { Notification } from '@sms/plasma-ui';
import { Icon } from '@sms/plasma-ui/lib/components/Icon/Icon';

import { GroupSequence } from '../../types/GroupSequence';
import { SequenceScenario } from '../../types/SequenceScenario';
import {
  ColoredInformation,
  InfoContainer,
  Information,
  MainContainer,
  StatusContainer,
  StatusText,
  Title,
  TitleContainer,
} from './styles';

interface Props {
  itemData: Partial<SequenceScenario>;
  sequence: GroupSequence | null;
}

const MasterItem: React.FC<Props> = ({ itemData, sequence }) => {
  const checkIfIsSync = () => {
    if (itemData.isOptimized !== null && !itemData.isOptimized) {
      return Notification.warning('app.api.generic.optimizer.warning.message');
    }
  };

  return (
    <MainContainer onClick={checkIfIsSync}>
      <TitleContainer>
        <Title>{itemData.name}</Title>
      </TitleContainer>
      <InfoContainer>
        <Information>{`Material Filter: ${itemData.materialFilterName}`}</Information>
        <Information>{`Materials: ${itemData.materials}`}</Information>
        <Information>
          Rule Violations:
          <ColoredInformation isNotZero={itemData.ruleViolation! > 0}>{itemData.ruleViolation}</ColoredInformation>
        </Information>
      </InfoContainer>
      {itemData.isOptimized !== null && !itemData.isOptimized ? (
        <StatusContainer>
          <Icon name="commons-clock_8" />
          <StatusText>SYNC. OPTIMIZER</StatusText>
        </StatusContainer>
      ) : (
        <>
          {itemData.selected && (
            <StatusContainer>
              <Icon name="commons-checked" />
              {sequence?.planningStatus === 'SENT TO MES' ? (
                <StatusText>SENT TO MES</StatusText>
              ) : (
                <StatusText>SELECTED FOR PRODUCTION</StatusText>
              )}
            </StatusContainer>
          )}
        </>
      )}
    </MainContainer>
  );
};

export default MasterItem;
