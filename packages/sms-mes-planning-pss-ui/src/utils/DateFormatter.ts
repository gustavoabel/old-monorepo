import dayjs from 'dayjs';

export function DateFormatter(date: string, type: 'date' | 'datetime' = 'datetime') {
  let format;

  if (type === 'date') {
    format = 'YYYY-MM-DD';
  } else {
    format = 'YYYY-MM-DD HH:mm:ss';
  }
  const dateJs = dayjs(date);

  return dateJs.format(format);
}
