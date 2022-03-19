import React, { useMemo } from 'react';

import { DataTable, RowComponent, withComponent, Tabulator, LoadingIndicator, ColumnDefinition } from '@sms/plasma-ui';

import { DynamicObject } from '../../types/DynamicObject';
import TableTitle from '../TableTitle';

interface MaterialDataTableProps {
  data: DynamicObject[];
  title: string;
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  columns: ColumnDefinition<any>[];
  onReady: (table?: Tabulator<DynamicObject>) => void;
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  onClick: (_: any, row: RowComponent<any>) => void;
  onMoved: (row: RowComponent<DynamicObject>) => void;
  onRowFormat?: (row: RowComponent<DynamicObject>) => JSX.Element;
}

function MaterialDataTable(props: MaterialDataTableProps) {
  const { data, title, columns, onReady, onClick, onMoved, onRowFormat } = props;

  const dataTable = useMemo(
    () => (
      <DataTable
        movableColumns
        layout="fitDataStretch"
        movableRows
        dataTree
        addable={false}
        editable={false}
        deletable={false}
        selectable={1}
        data={data}
        columns={columns}
        toolbar={{ showTitle: true, title: <TableTitle unitName={title} /> }}
        selectedRow={1}
        rowClick={onClick}
        rowMoved={onMoved}
        rowFormatter={onRowFormat}
        dataLoading={() => LoadingIndicator.show()}
        dataLoaded={() => LoadingIndicator.hide()}
        onReady={onReady}
      />
    ),
    // eslint-disable-next-line react-hooks/exhaustive-deps
    [data],
  );

  return <>{dataTable}</>;
}

export default withComponent(MaterialDataTable);
