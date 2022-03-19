import { Col, Divider, Select } from '@sms/plasma-ui';
import { Widget } from '@sms/plasma-ui/lib/components/Widget/Widget';
import styled from 'styled-components';

interface HighlightTextColor {
  color?: string;
}

export const StyledDivider = styled(Divider)`
  margin: 0 0 16px !important;
`;

export const StyledCol = styled(Col)`
  display: flex;
  align-items: flex-end;
  padding-bottom: 16px !important;
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

export const HighlightText = styled.span<HighlightTextColor>`
  color: '#24a148';
  font-style: normal;
  font-weight: 500;
  font-size: 14px;
  line-height: 16px;
`;

export const Text = styled.span`
  font-size: 12px;
  font-weight: bold;
  color: #393939;
  line-height: normal;
  text-transform: uppercase;
  white-space: nowrap;
  text-overflow: ellipsis;
  overflow: hidden;
  display: block;
  height: auto;
  margin-right: 6px;
`;

export const NumberText = styled.span<HighlightTextColor>`
  color: ${({ color }) => (color ? color : '#24a148')};
  font-style: normal;
  font-weight: 500;
  font-size: 13px;
  line-height: 16px;
`;

export const CustomWidget = styled(Widget)`
  width: fit-content;
  margin-left: 12px;
`;

export const InfoCardList = styled.div`
  border-bottom: 1px solid #999;
  padding-bottom: 16px;
`;
