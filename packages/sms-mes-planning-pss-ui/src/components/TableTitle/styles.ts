import { Icon } from '@sms/plasma-ui';
import styled from 'styled-components';

export const StyledIcon = styled(Icon)`
  svg {
    font-size: 18px !important;
    color: black !important;
  }
`;

export const Container = styled.div`
  align-items: center;
  display: flex;
  gap: 4px;
`;

export const TooltipContainer = styled.div`
  font-weight: bold;
  flex-direction: column;
  span {
    flex-direction: row
    display: flex;
  }
`;
