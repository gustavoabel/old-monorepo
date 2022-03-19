import styled from 'styled-components';

export const Container = styled.div<{ size?: number }>`
  .ant-empty {
    ${({ size }) => (size && size < 30 ? `display: none;` : 'display: flex;')};
    position: absolute;
    max-height: ${({ size }) => {
    if (!size) {
      return 'calc(100vh - 400px) !important';
    } else if (Number(size.toFixed(2)) - 5.25 < 25) {
      return 'auto';
    } else if (Number(size.toFixed(2)) < 40) {
      return `calc((100vh - 400px) * ((${Number(size.toFixed(2))} - 7.5) / 100)) !important`;
    } else {
      return `calc((100vh - 400px) * ((${Number(size.toFixed(2))} - 5.25) / 100)) !important`;
    }
  }};
    top: 50%;
    border: none !important;
    z-index: unset;
    transform: translateY(-50%);
  }
  .tabulator .tabulator-tableHolder .tabulator-table .tabulator-row.tabulator-selected {
    background-color: #E5F6FF !important;
    font-weight: bold;
  }

  .tabulator {
    ${({ size }) => (size && Number(size.toFixed(2)) - 5.25 < 6 ? `display: none;` : 'display: block;')}
  }

  .tabulator-tableHolder {
    overflow-y: auto !important;
    height: ${({ size }) => {
    if (!size) {
      return 'calc(100vh - 400px) !important';
    } else if (Number(size.toFixed(2)) < 30) {
      return `calc((100vh - 400px) * ((${Number(size.toFixed(2))} - 15) / 100)) !important`;
    } else if (Number(size.toFixed(2)) < 40) {
      return `calc((100vh - 400px) * ((${Number(size.toFixed(2))} - 7.5) / 100)) !important`;
    } else {
      return `calc((100vh - 400px) * ((${Number(size.toFixed(2))} - 5.25) / 100)) !important`;
    }
  }};
  }
`;
