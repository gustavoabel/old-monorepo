import React from 'react';

import { NoContentDiv, NoContentIcon, NoContentRow, NoContentTitle } from './styles';

interface Props {
  tableTitle?: string;
}

const NoDataMessage: React.FC<Props> = ({ tableTitle }) => {
  return (
    <NoContentDiv>
      <NoContentTitle>{tableTitle || ''}</NoContentTitle>
      <NoContentIcon name="data-table_1" />
      <NoContentRow>No Data</NoContentRow>
    </NoContentDiv>
  );
};

export default NoDataMessage;
