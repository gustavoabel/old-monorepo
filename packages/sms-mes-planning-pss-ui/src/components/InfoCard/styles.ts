import styled from 'styled-components';

interface LimitProps {
  hasLimit?: boolean;
  overLimit?: boolean;
}

export const CustomKPICard = styled.div`
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
  padding: 8px;

  font-size: 14px;
  line-height: 14px;
  letter-spacing: 0.3px;
  background-color: #e0e0e0;
  border: 1px solid #e0e0e0;
`;

export const KPIValue = styled.div<LimitProps>`
  display: inline-block;
  width: auto;
  padding: 8px;

  font-size: 14px;
  line-height: 14px;

  letter-spacing: 0.3px;
  font-weight: ${({ hasLimit }) => (hasLimit ? '600' : '0')};
  color: ${({ hasLimit }) => (hasLimit ? '#ffffff' : '#000000')};
  background-color: ${({ overLimit, hasLimit }) => (hasLimit ? (overLimit ? '#ED4245' : '#45C06C') : '#ffffff')};
  border: 1px solid ${({ overLimit, hasLimit }) => (hasLimit ? (overLimit ? '#ED4245' : '#45C06C') : '#e0e0e0')};
`;
