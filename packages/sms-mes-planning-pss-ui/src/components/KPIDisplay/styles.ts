import styled from 'styled-components';

export const Container = styled.div`
  display: flex;
  flex-direction: row;
  flex-wrap: nowrap;
  align-items: center;
  justify-content: flex-start;

  width: 100%;
  height: calc(40px - 1px);
  margin: -8px -8px 0px -8px;
  border-bottom: 1px solid #e0e0e0;

  background-color: #f4f4f4;
  color: rgba(0, 0, 0, 0.85);
`;

export const KPIList = styled.div`
  flex: 1 1 auto;
  padding: 0 16px;

  display: flex;
  flex-wrap: nowrap;

  background-color: #f4f4f4;
  color: rgba(0, 0, 0, 0.85);

  overflow-x: scroll;
  overflow-y: hidden;
  scroll-behavior: smooth;
  -webkit-overflow-scrolling: touch;

  ::-webkit-scrollbar {
    width: 0; /* Remove scrollbar space */
    height: 0; /* Remove scrollbar space */
    background: transparent; /* Optional: just make scrollbar invisible */
  }
  /* Optional: show position indicator in red */
  ::-webkit-scrollbar-thumb {
    background: transparent;
  }
`;

export const CommandsContainer = styled.div`
  flex: 1 1 auto;

  display: flex;
  flex-direction: row;
  flex-wrap: nowrap;
  align-items: center;
  justify-content: center;

  background-color: #f4f4f4;
  color: rgba(0, 0, 0, 0.85);
`;

export const KPICard = styled.div`
  flex: 0 0 auto;
  width: min-content;

  display: inline-block;
  width: auto;

  &:not(:last-child) {
    margin-right: 16px;
  }
`;

export const KPIName = styled.div`
  display: inline-block;
  width: auto;
  padding: 4px;

  font-size: 12px;
  line-height: 14px;

  background-color: #e0e0e0;
`;

export const KPIValue = styled.div`
  display: inline-block;
  width: auto;
  padding: 4px;

  font-size: 12px;
  line-height: 14px;

  background-color: #ffffff;
`;
