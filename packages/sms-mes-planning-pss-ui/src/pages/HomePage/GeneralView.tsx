import React from 'react';

import { withComponent } from '@sms/plasma-ui';

import { DynamicSplit } from '../../components';

// import { Container } from './styles';

interface Props {
  refetchSequenceList?: () => Promise<void>;
}

const SequenceGeneralView: React.FC<Props> = () => {
  return <DynamicSplit />;
};

export default withComponent(SequenceGeneralView);
