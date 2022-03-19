export function StatusColorize(status?: string) {
  if (status) {
    switch (status.toLowerCase()) {
      case 'planning':
        return '#ee5396';

      case 'booked':
        return '#0F62FE';

      case 'sent to mes':
        return '#24A148';

      default:
        return '#fff';
    }
  }

  return '#fff';
}
