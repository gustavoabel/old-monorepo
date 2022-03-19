import { Button } from '@sms/plasma-ui';
import styled from 'styled-components';

export const Container = styled.div`
  display: flex;
  flex-direction: row;
  flex-wrap: nowrap;
  align-items: center;
  overflow: hidden;

  height: 47px;
`;

export const Content = styled.div`
  display: flex;
  align-items: center;
  overflow: hidden;

  flex: 1 1 auto;
  height: 100%;
  padding: 4px 0;

  &:not(:first-child) {
    padding-left: 8px;
    margin-left: 16px;
    border-left: 1px solid #e0e0e0;
  }
`;

export const Title = styled.span`
  display: inherit;
  align-items: center;
  margin: 0 16px 0 0;

  font-size: 16px;
  font-weight: 500;
  line-height: normal;
  color: #161616;

  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
`;

export const EllipsisButton = styled(Button)`
  svg {
    font-size: 24px;
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

export const ModalTitle = styled.span`
  font-size: 14px;
  font-weight: 700;
  line-height: normal;
  color: #0775be;
`;

export const ModalText = styled.span`
  font-size: 14px;
  font-weight: 500;
  line-height: 20px;
  margin-top: 16px;
`;

export const ModalContainer = styled.div`
  display: flex;
  flex-direction: column;
  flex-wrap: nowrap;
  overflow: hidden;
`;
