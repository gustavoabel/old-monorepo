import { ColumnDefinition } from '@sms/plasma-ui';

/* eslint-disable @typescript-eslint/no-explicit-any */
export function UniqueColumnsList(array: ColumnDefinition<any>[]) {
  const a = array.concat();

  for (let i = 0; i < a.length; ++i) {
    for (let j = 0; j < a.length; ++j) {
      if (i !== j) {
        if (a[i].field === a[j].field) a.splice(j, 1);
      }
    }
  }

  return a;
}
