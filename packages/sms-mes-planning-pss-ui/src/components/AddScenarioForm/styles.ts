import { Col, Divider, Row, Select } from '@sms/plasma-ui';
import styled from 'styled-components';

export const StyledDivider = styled(Divider)`
  margin: 0 0 16px !important;
`;

export const StyledCol = styled(Col)`
  display: flex;
  align-items: flex-end;
  padding-bottom: 16px !important;
`;

export const TableEmpty = styled.div`
  height: 30vh;
`;

export const TableContainer = styled.div<{ size?: number }>`
  .tabulator-tableHolder {
    overflow-y: auto !important;
  }
`;

export const PopoverLink = styled(Select.Option)`
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

export const HighlightText = styled.span`
  color: #24a148;
  font-style: normal;
  font-weight: 500;
  font-size: 14px;
  line-height: 16px;
`;

export const Container = styled(Row)`
  margin-top: 8px;
  margin-bottom: 8px;
  padding: auto 8px;
  border-bottom: 1px solid #eee;
`;
