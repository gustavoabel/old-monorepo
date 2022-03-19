export const formatNumber = (value: unknown) => {
  const fixedValue = Number(value).toFixed(2);
  return fixedValue.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
};
