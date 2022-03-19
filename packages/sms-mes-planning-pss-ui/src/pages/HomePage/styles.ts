import { Button, Row } from '@sms/plasma-ui';
import styled from 'styled-components';

import { StatusColorize } from '../../utils';

export const Container = styled.div`
  margin-top: 16px;
  margin-right: -8px;
`;

export const SearchAreaContainer = styled.div``;

export const StatusLabel = styled.span`
  display: block;
  font-size: 12px;
  line-height: 1.8;
  color: #6f6f6f;
`;

export const StatusSign = styled.div<{ status?: string }>`
  display: inline-block;
  width: 10px;
  height: 10px;
  margin: 2px 2px 0;
  background-color: ${({ status }) => StatusColorize(status)};
  border-radius: 50%;
`;

export const EllipsisButton = styled(Button)`
  width: 16px !important;

  [class^='Icon'] {
    display: inline-block;
  }

  svg {
    color: #161616 !important;
  }
`;

export const PopoverLink = styled(Button)`
  width: 100%;
  margin: 0 !important;
  padding: 0 4px;
  color: #161616 !important;
  transition: all ease-in-out 400ms;

  svg {
    color: #161616 !important;
  }

  &:hover {
    background-color: #f2f2f2 !important;
    border-color: #f2f2f2 !important;
  }
`;

export const SelectButtonContainer = styled.div`
  display: 'flex';
  flex-wrap: nowrap;
  padding: 4px 8px 0;
`;

export const StyledRow = styled(Row)`
  width: 100%;
`;
