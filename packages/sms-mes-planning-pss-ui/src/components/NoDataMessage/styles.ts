import { Row } from '@sms/plasma-ui';
import { Icon } from '@sms/plasma-ui/lib/components/Icon/Icon';
import styled from 'styled-components';

export const NoContentDiv = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  width: 100%;
  flex-direction: column;
`;

export const NoContentIcon = styled(Icon)`
  font-size: 4rem;
`;

export const NoContentRow = styled(Row)`
  font-size: 14px;
  color: #8d8d8d;
`;

export const NoContentTitle = styled.span`
  position: absolute;
  top: 12px;
  left: 12px;
  text-transform: capitalize;
`;
