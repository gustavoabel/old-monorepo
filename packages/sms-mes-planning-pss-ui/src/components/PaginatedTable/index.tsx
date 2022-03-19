import React from 'react';
import { ReactTabulator } from 'react-tabulator';

import { useTranslation } from '@sms/plasma-ui';

import { DynamicObject } from '../../types/DynamicObject';
import { StyledIcon, TableContainer, TableEmpty, TabulatorContainer } from './styles';

interface Props {
  firstEmptyRender: boolean;
  data: DynamicObject[];
  maxSelectableRows: number | boolean;
  columnDefinitions: DynamicObject[];
  tableHeight: number;
  handleColumnMoved: (data: unknown) => Promise<void>;
  handleRowSelection: (data: unknown) => void;
}

const PaginatedTable: React.FC<Props> = ({
  firstEmptyRender,
  data,
  maxSelectableRows,
  columnDefinitions,
  tableHeight,
  handleColumnMoved,
  handleRowSelection,
}) => {
  const { t } = useTranslation();

  return (
    <>
      {firstEmptyRender ? (
        <span />
      ) : (
        <>
          {data.length > 0 ? (
            <>
              <TableContainer id="TableContainer">
                <TabulatorContainer>
                  <ReactTabulator
                    data={data}
                    columns={columnDefinitions}
                    options={{
                      pagination: 'local',
                      paginationSize: 50,
                      layout: 'fitData',
                      height: tableHeight,
                      rowSelectionChanged: handleRowSelection,
                      selectable: maxSelectableRows,
                      columnMoved: handleColumnMoved,
                      movableColumns: true,
                      headerFilter: true,
                    }}
                  />
                </TabulatorContainer>
              </TableContainer>
            </>
          ) : (
            <TableEmpty>
              <StyledIcon name="data-table_1" />
              <p>{t('app.forms.emptyTable')}</p>
            </TableEmpty>
          )}
        </>
      )}
    </>
  );
};

export default PaginatedTable;
