import styled from 'styled-components';

interface ColoredInformationProps {
  isNotZero?: boolean;
}

export const MainContainer = styled.div`
  height: auto;
  display: flex;
  flex-direction: column;
  padding: 8px;
`;

export const TitleContainer = styled.div`
  margin-bottom: -18px;
`;

export const Title = styled.p`
  font-weight: bold;
  font-size: 16px;
`;

export const InfoContainer = styled.div`
  display: flex;
  flex-direction: column;
`;

export const Information = styled.p`
  display: flex;
  margin-bottom: -6px;
  line-height: 2;
`;

export const ColoredInformation = styled.p<ColoredInformationProps>`
  color: ${({ isNotZero }) => (isNotZero ? '#E51F2C' : 'black')};
  margin: 0 0 0 6px;
  line-height: 2;
`;

export const DividedInfoContainer = styled.div`
  display: flex;
  flex-direction: row;
  > * {
    &:first-child {
      margin-right: 20px;
    }
  }
`;

export const StatusContainer = styled.div`
  display: flex;
  flex-direction: row;
  color: #0775be;
  align-items: center;
`;

export const StatusText = styled.p`
  font-weight: bold;
  font-size: 11.5px;
  margin: 1px 0 0 3px;
`;
