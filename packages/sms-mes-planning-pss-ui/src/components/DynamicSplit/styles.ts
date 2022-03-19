import { Split as PlasmaSplit } from '@sms/plasma-ui';
import styled from 'styled-components';

export const Wrapper = styled.div`
  max-height: 75vh;

  .vertical {
    height: unset;
  }
`;

export const Split = styled(PlasmaSplit)``;

export const Panel = styled(Split.Panel)`
  margin: 8px;
  padding: 16px;
`;
