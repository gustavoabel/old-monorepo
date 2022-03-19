import { RowComponent } from '@sms/plasma-ui';

export function GetRowComponentData(data: RowComponent<any>) {
  const prevRow = data.getPrevRow();
  const nextRow = data.getNextRow();
  const treeParentRow = data.getTreeParent();

  let prevLine: any;
  let nextLine: any;
  let treeParentLine: any;

  const currentLine = data.getData();

  if (prevRow && prevRow !== null) {
    prevLine = prevRow && prevRow.getData();
  }

  if (nextRow && nextRow !== null) {
    nextLine = nextRow && nextRow.getData();
  }

  if (treeParentRow && treeParentRow !== null) {
    treeParentLine = treeParentRow && treeParentRow.getData();
  }

  return {
    currentLine,
    prevLine,
    nextLine,
    treeParentLine,
  };
}
