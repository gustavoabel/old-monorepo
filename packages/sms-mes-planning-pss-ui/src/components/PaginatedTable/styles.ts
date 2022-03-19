import { Icon as PlasmaIcon, Pagination } from '@sms/plasma-ui';
import styled from 'styled-components';

import theme from '../../utils/themes';

export const TableEmpty = styled.div`
  height: 50vh;
  display: flex;
  flex-direction: column;
  flex-wrap: nowrap;
  align-content: center;
  justify-content: center;
  align-items: center;
  font-size: 16px;
  color: #6f6f6f;
  border: 1px solid #e0e0e0;
`;

export const TableContainer = styled.div<{ size?: number }>`
  .tabulator-tableHolder {
    overflow-y: auto !important;
  }
`;

export const StyledIcon = styled(PlasmaIcon)`
  font-size: 4rem !important;
  color: black !important;
`;

export const StyledPagination = styled(Pagination)`
  float: right;
  margin-top: 6px;

  .ant-pagination-item.ant-pagination-item-active a {
    color: #ffffff;
  }

  .ant-pagination-item.ant-pagination-item-active {
    background-color: #0075be;
  }
`;

export const Icon = styled.div`
  -moz-osx-font-smoothing: grayscale;
  -webkit-font-smoothing: antialiased;
  display: inline-block;
  font-style: normal;
  font-variant: normal;
  text-rendering: auto;
  line-height: 1;
  svg {
    font-size: 24px;
    color: ${() => theme.mode.icon.iconColor};
  }
`;

export const DataTableActions = styled.div`
  display: none;
  align-items: center;
  justify-content: flex-end;
  flex: 1 1;
  min-height: calc(${() => theme.layout.dataTable.height} - 1px);
  position: fixed;
  right: 0;
  padding: 0 calc(${() => theme.layout.padding.sm}) 0 calc(${() => theme.layout.padding.sm} * 2);
  background-color: ${() => theme.mode.dataTable.backgroundColor};
  margin: 0px;
  margin-top: 0px;
  border-radius: 0px;
  div {
    svg {
      color: ${() => theme.mode.dataTable.iconColor};
      font-size: ${() => theme.layout.dataTable.iconSize};
    }
    & + div {
      margin-left: calc(${() => theme.layout.margin.sm} / 2);
    }
    &.disable-icon {
      svg {
        color: ${() => theme.mode.dataTable.iconColorDisabled};
      }
    }
    &.enable-icon {
      svg {
        color: ${() => theme.mode.dataTable.iconColorEnabled};
      }
    }
  }
  .digital-icon {
    color: ${() => theme.mode.dataTable.iconColor};
    font-size: 24px;
    & + .digital-icon {
      margin-left: 2px;
    }
    &.disable-icon {
      opacity: 0.5;
      pointer-events: none;
    }
    &.enable-icon {
      opacity: 1;
      color: ${() => theme.mode.colors.primary};
    }
  }
`;

export const TabulatorContainer = styled.div`
  display: grid;
  .tabulator {
    overflow: hidden;
    font-size: ${() => theme.layout.dataTable.fontSize};
    text-align: left;
    transform: translatez(0);
    position: relative;
    background-color: ${() => theme.mode.dataTable.backgroundColor};
    padding: 0px;
    margin: 0px;
    border: 1px solid ${() => theme.mode.dataTable.borderColor};
    .tabulator-footer {
      .tabulator-page {
        &.active {
          background: #0075be;
          color: #ffffff;
        }
        border: none;
        border-radius: 0;
      }
    }
    .tabulator-header {
      position: relative;
      box-sizing: border-box;
      width: 100%;
      white-space: nowrap;
      overflow: hidden;
      user-select: none;
      border-bottom: 1px solid ${() => theme.mode.dataTable.borderColor};
      background-color: ${() => theme.mode.dataTable.backgroundColorHover};
      color: ${() => theme.mode.dataTable.textColor};
      font-weight: 500;
      font-size: 12px;
      .tabulator-col {
        display: inline-block;
        position: relative;
        box-sizing: border-box;
        text-align: left;
        vertical-align: bottom;
        overflow: hidden;
        background-color: transparent;
        padding: 0px ${() => theme.layout.padding.sm};
        height: auto !important;
        border-right: 1px solid ${() => theme.mode.dataTable.borderColor};
        &:last-child {
          border-right: 0px;
        }
        .tabulator-col-content {
          box-sizing: border-box;
          position: relative;
          padding: 0px;
          display: table-cell;
          vertical-align: middle;
          height: ${() => theme.layout.dataTable.height};
          .tabulator-col-title-holder {
            position: relative;
            .tabulator-col-title {
              text-transform: uppercase;
            }
            .tabulator-arrow {
              top: 7px;
              right: 19px;
            }
          }
        }
        .tabulator-col-sorter {
          display: inline-block;
        }
        &.tabulator-sortable[aria-sort='none'] .tabulator-col-content .tabulator-arrow {
          border: 0px;
          &::before {
            content: '\\f0dc';
            font-family: 'Font Awesome 5 Pro';
            font-size: 14px;
            font-weight: 700;
            color: ${() => theme.mode.colors.primary};
            display: inline-block;
          }
        }
        &.tabulator-sortable[aria-sort='asc'] .tabulator-col-content .tabulator-arrow {
          border: 0px;
          &::before {
            content: '\\f0de';
            font-family: 'Font Awesome 5 Pro';
            font-size: 14px;
            font-weight: 700;
            color: ${() => theme.mode.colors.primary};
            display: inline-block;
          }
        }
        &.tabulator-sortable[aria-sort='desc'] .tabulator-col-content .tabulator-arrow {
          border: 0px;
          &::before {
            content: '\\f0dd';
            font-family: 'Font Awesome 5 Pro';
            font-size: 14px;
            font-weight: 700;
            color: ${() => theme.mode.colors.primary};
            display: inline-block;
          }
        }
      }
    }
    .tabulator-tableHolder {
      position: relative;
      width: 100%;
      white-space: nowrap;
      overflow: hidden;
      overflow-x: auto; // overflow-x enabled
      //display: inline-flex;// overflow-x enabled
      .tabulator-table {
        position: relative;
        background-color: ${() => theme.mode.dataTable.backgroundColor};
        white-space: normal;
        overflow: hidden;
        color: ${() => theme.mode.dataTable.textColor};
        display: inline;
        display: inline-block; // overflow-x enabled
        .tabulator-row {
          border-bottom: 1px solid ${() => theme.mode.dataTable.borderColor};
          background-color: ${() => theme.mode.dataTable.backgroundColor};
          min-height: ${() => theme.layout.dataTable.height};
          vertical-align: middle;
          line-height: ${() => theme.layout.dataTable.height};
          box-sizing: content-box;
          white-space: nowrap;
          position: relative;
          &:hover {
            background-color: ${() => theme.mode.dataTable.backgroundColorHover} !important;
          }
          &.tabulator-selected {
            background-color: ${() => theme.mode.dataTable.backgroundColorActive} !important;
            &:hover {
              background-color: ${() => theme.mode.dataTable.backgroundColorActive} !important;
            }
          }
          .tabulator-cell {
            position: relative;
            box-sizing: border-box;
            vertical-align: middle;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            padding: 0px;
            border: 0px;
            display: inline-block; //it was table-cell
            height: ${() => theme.layout.dataTable.height} !important;
            min-height: ${() => theme.layout.dataTable.height} !important;
            padding: 0px ${() => theme.layout.padding.sm};
            a {
              color: ${() => theme.mode.dataTable.linkColor};
            }
            > div:first-child:not(.tabulator-data-tree-control) {
              text-overflow: ellipsis;
              white-space: nowrap;
              overflow: hidden;
              height: 100%;
              display: flex;
              align-items: center;
              .ant-badge {
                height: 100% !important;
              }
              .anticon {
                height: ${() => theme.layout.dataTable.height};
                display: flex;
                align-items: center;
                justify-content: left;
                font-size: 24px;
              }
            }
            div {
              .ant-btn {
                padding: 0px !important;
              }
              div {
                .ant-btn {
                  padding: 0px !important;
                }
              }
            }
            > div.tabulator-data-tree-control {
              display: inline-flex;
              justify-content: center;
              align-items: center;
              vertical-align: middle;
              border: 0px;
              border-radius: 0px;
              background: transparent;
              width: 14px;
              height: ${() => theme.layout.dataTable.height};
              margin-right: 4px;
              margin-left: 7px !important;
              float: left;
              cursor: pointer;
              outline: 0;
              .tabulator-data-tree-control-expand {
                border: 0px !important;
                display: flex;
                align-items: center;
                justify-content: center;
                height: ${() => theme.layout.dataTable.height};
                width: 14px;
                background-color: transparent;
                &::before {
                  content: '\\f105';
                  font-family: 'Font Awesome 5 Pro';
                  font-size: 16px;
                  font-weight: 400;
                  color: #6f6f6f;
                  display: block;
                }
                &::after {
                  display: none;
                }
                &:focus {
                  outline: 0;
                }
              }
              .tabulator-data-tree-control-collapse {
                border: 0px !important;
                display: flex;
                align-items: center;
                justify-content: center;
                height: ${() => theme.layout.dataTable.height};
                width: 14px;
                &::before {
                  content: '\\f107';
                  font-family: 'Font Awesome 5 Pro';
                  display: block;
                  font-size: 16px;
                  font-weight: 400;
                  color: #6f6f6f;
                  display: block;
                }
                &::after {
                  display: none;
                }
                &:focus {
                  outline: 0;
                }
              }
              & ~ div {
                .ant-list-item-meta {
                  height: ${() => theme.layout.dataTable.height};
                  align-items: center;
                  .ant-list-item-meta-avatar {
                    margin-right: 0px;
                    margin-bottom: 0px;
                    height: ${() => theme.layout.dataTable.height};
                    min-width: calc(${() => theme.layout.dataTable.height} - 16px);
                    width: 24px;
                    display: flex;
                    align-content: center;
                    justify-content: center;
                    .digital-icon {
                      display: flex;
                      flex: 1;
                      align-items: center;
                      justify-content: center;
                      font-size: 24px;
                      color: ${() => theme.mode.dataTable.iconColor};
                    }
                  }
                  .ant-list-item-meta-content {
                    width: auto;
                    color: #393939;
                    background-color: transparent;
                    display: flex;
                    height: ${() => theme.layout.dataTable.height};
                    align-items: center;
                    padding-left: 8px;
                    min-width: 0;
                    flex: 1;
                    .ant-list-item-meta-title {
                      font-size: ${() => theme.layout.dataTable.fontSize};
                      color: ${() => theme.mode.dataTable.textColor};
                      font-weight: 400;
                      margin: 0px;
                      height: ${() => theme.layout.dataTable.height};
                      line-height: ${() => theme.layout.dataTable.height};
                      display: inline-block;
                      overflow: hidden;
                      text-overflow: ellipsis;
                      white-space: nowrap;
                      margin: 0px;
                    }
                  }
                }
              }
            }
            > div.tabulator-data-tree-branch {
              display: inline-block;
              vertical-align: middle;
              height: 40px;
              width: 8px;
              margin-top: 0px;
              margin-right: 0px;
              border-radius: 0px;
              border: 0px;
              & ~ div {
                .ant-list-item-meta {
                  height: ${() => theme.layout.dataTable.height};
                  align-items: center;
                  .ant-list-item-meta-avatar {
                    margin-right: 0px;
                    margin-bottom: 0px;
                    height: ${() => theme.layout.dataTable.height};
                    width: 24px;
                    display: flex;
                    align-content: center;
                    justify-content: center;
                    .digital-icon {
                      display: flex;
                      flex: 1;
                      align-items: center;
                      justify-content: center;
                      font-size: 24px;
                      color: ${() => theme.mode.dataTable.iconColor};
                    }
                  }
                  .ant-list-item-meta-content {
                    width: auto;
                    color: #393939;
                    background-color: transparent;
                    display: flex;
                    height: ${() => theme.layout.dataTable.height};
                    align-items: center;
                    padding-left: 8px;
                    min-width: 0;
                    flex: 1;
                    .ant-list-item-meta-title {
                      font-size: ${() => theme.layout.dataTable.fontSize};
                      color: ${() => theme.mode.dataTable.textColor};
                      font-weight: 400;
                      margin: 0px;
                      height: ${() => theme.layout.dataTable.height};
                      line-height: ${() => theme.layout.dataTable.height};
                      display: inline-block;
                      overflow: hidden;
                      text-overflow: ellipsis;
                      white-space: nowrap;
                      margin: 0px;
                    }
                  }
                }
              }
            }
            .ant-list-item-meta {
              .ant-list-item-meta-avatar {
                margin-right: 0px;
                margin-bottom: 0px;
                height: 32px;
                width: 32px;
                display: flex;
                align-content: center;
                justify-content: center;
                .digital-icon {
                  display: flex;
                  flex: 1;
                  align-items: center;
                  justify-content: center;
                  color: ${() => theme.mode.dataTable.iconColor};
                }
              }
              .ant-list-item-content {
                .ant-list-item-meta-title {
                  font-size: ${() => theme.layout.dataTable.fontSize};
                  color: ${() => theme.mode.dataTable.textColor};
                  line-height: normal;
                  font-weight: 400;
                  margin: 0px;
                  height: 32px;
                  display: table-cell;
                }
              }
            }
            .tabulator-col-resize-handle {
              position: absolute;
              right: 0;
              top: 0;
              bottom: 0;
              width: 5px;
            }
            ${DataTableActions}
            .ant-form-item {
              margin-bottom: 0px;
              .ant-form-item-control-input {
                min-height: ${() => theme.layout.dataTable.height};
              }
            }
          }
          .tabulator-cell.editable-cell span:hover {
            cursor: pointer;
          }
          .tabulator-cell.tabulator-editing .ant-form-item-label {
            display: none;
          }
          .tabulator-cell.editable-cell.tabulator-editing .ant-form-item-control .ant-input-number,
          .tabulator-cell.editable-cell.tabulator-editing .ant-form-item-control .ant-input,
          .tabulator-cell.editable-cell.tabulator-editing .ant-form-item-control .ant-input-number:focus,
          .tabulator-cell.editable-cell.tabulator-editing .ant-form-item-control .ant-input:focus {
            border: 1px solid ${() => theme.mode.colors.primary} !important;
            box-shadow: 0px 0px 0px transparent;
            outline: none;
            width: auto;
          }
          .nested-row-container {
            background-color: ${() => theme.mode.dataTable.backgroundColor};
            display: none;
          }
          .nested-row-container.open {
            border-top: 1px solid ${() => theme.mode.dataTable.borderColor};
            display: block;
            padding: ${() => theme.layout.padding.sm};
          }
          &:hover {
            background-color: ${() => theme.mode.dataTable.backgroundColorHover};
          }
          &:hover {
            .tabulator-cell {
              ${DataTableActions} {
                display: flex;
                background-color: ${() => theme.mode.dataTable.backgroundColorHover};
                ${Icon}:hover {
                  cursor: pointer;
                }
              }
            }
          }
          &.tabulator-selected {
            background-color: ${() => theme.mode.dataTable.backgroundColorActive};
            .tabulator-cell {
              ${DataTableActions} {
                display: flex;
                background-color: ${() => theme.mode.dataTable.backgroundColorActive};
              }
            }
            & ~ .tabulator-row:hover {
              .tabulator-cell {
                ${DataTableActions} {
                  display: none;
                }
              }
            }
          }
          &:last-child {
            border-bottom: 0px;
          }
        }
      }
      .tabulator-row.tabulator-group {
        border: 0px;
        border-bottom: 1px solid ${() => theme.mode.dataTable.borderColor};
        padding: 0px;
        padding-left: 12px;
        font-weight: 500;
        background-color: ${() => theme.mode.dataTable.backgroundColorHover};
        span {
          margin-left: calc(${() => theme.layout.margin.sm} / 2);
          font-weight: 400;
        }
        .tabulator-group-toggle {
          width: 14px;
          height: ${() => theme.layout.dataTable.height};
          margin-right: calc(${() => theme.layout.margin.sm} / 2);
          float: left;
          cursor: pointer;
          .tabulator-arrow {
            border: 0px !important;
            display: block;
            &::before {
              content: '\\f105';
              font-family: 'Font Awesome 5 Pro';
              display: block;
              font-size: 18px;
              font-weight: 400;
              color: #6f6f6f;
              display: block;
            }
          }
        }
        &:last-child {
          border-bottom: 0px !important;
        }
      }
      .tabulator-row.tabulator-group ~ .tabulator-row:not(.tabulator-group) {
        border: 0px;
        .tabulator-cell {
          border: 0px;
          border-bottom: 1px solid ${() => theme.mode.dataTable.borderColor};
        }
      }
      .tabulator-row.tabulator-group ~ .tabulator-row:last-child {
        .tabulator-cell {
          border-bottom: 0px;
        }
      }
      .tabulator-row.tabulator-group.tabulator-group-visible {
        .tabulator-group-toggle {
          width: 14px;
          height: ${() => theme.layout.dataTable.height};
          margin-right: calc(${() => theme.layout.margin.sm} / 2);
          float: left;
          cursor: pointer;
          .tabulator-arrow {
            border: 0px !important;
            display: block;
            &::before {
              content: '\\f107';
              font-family: 'Font Awesome 5 Pro';
              display: block;
              font-size: 18px;
              font-weight: 400;
              color: #6f6f6f;
              display: block;
            }
          }
        }
      }
      .tabulator-row.tabulator-group.tabulator-group-level-1 {
        padding-left: calc(${() => theme.layout.padding.sm} * 2);
      }
      .tabulator-row.tabulator-group.tabulator-group-level-2 {
        padding-left: 48px;
      }
      .tabulator-row.tabulator-row-editing {
        .tabulator-cell.editable-cell {
          > div:first-child {
            font-size: ${() => theme.layout.inputText.fontSize};
            font-weight: 400;
            color: ${() => theme.mode.dataTable.textColorActive};
            padding: 0 ${() => theme.layout.padding.sm};
            background-color: ${() => theme.mode.dataTable.backgroundColorHover};
            border: 1px solid transparent;
            border-bottom-color: #8d8d8d;
            height: ${() => theme.layout.inputText.height};
            line-height: ${() => theme.layout.inputText.lineHeight};
            border-radius: 0;
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden;
            display: inline-block;
            display: block;
            margin: 4px 0px;
          }
          &.tabulator-validation-fail {
            .ant-form-item-control {
              input {
                color: #f4f4f4 !important;
              }
              .ant-input {
                border-color: #e3000f !important;
                &:focus,
                &:active {
                  border-color: #e3000f !important;
                }
              }
              .ant-input-number {
                border-color: #e3000f !important;
                &:focus,
                &:active {
                  border-color: #e3000f !important;
                }
              }
              .ant-select {
                border-color: #e3000f !important;
              }
            }
          }
        }
        &:hover {
          background-color: red;
        }
        .tabulator-cell.editable-cell.tabulator-editing {
          > div:first-child {
            border: 0px solid #8d8d8d;
            padding: 0px;
          }
        }
      }
      &::-webkit-scrollbar {
        width: ${() => theme.layout.scroll.width};
        height: ${() => theme.layout.scroll.height};
      }
      &::-webkit-scrollbar-track {
        background: ${() => theme.mode.scroll.trackBackgroundColor};
      }
      &::-webkit-scrollbar-thumb {
        background: ${() => theme.mode.scroll.thumbBackgroundColor};
        border: 2px solid ${() => theme.mode.scroll.thumbBorderColor};
      }
      &::-webkit-scrollbar-thumb:hover {
        background: ${() => theme.mode.scroll.thumbBackgroundColorHover};
      }
      &::-webkit-scrollbar-button {
        display: none;
      }
    }
    &.tabulator-table-editing {
      .tabulator-row:not(.tabulator-selected) {
        pointer-events: none;
      }
    }
    &.movable-rows {
      .tabulator-tableHolder {
        .tabulator-table {
          .tabulator-row:hover {
            .tabulator-cell:nth-child(1)::before {
              content: '.';
              position: absolute;
              left: 4px;
              font-size: 14px;
              font-weight: bold;
              line-height: 20px;
              color: #6f6f6f;
              text-shadow: 0 4px #6f6f6f, 0 8px #6f6f6f, 0 12px #6f6f6f, 4px 0 #6f6f6f, 4px 4px #6f6f6f, 4px 8px #6f6f6f,
                4px 12px #6f6f6f;
              text-rendering: optimizeLegibility;
              -webkit-font-smoothing: antialiased;
              -moz-osx-font-smoothing: grayscale;
            }

            &:hover {
              .tabulator-cell:nth-child(1)::before {
                color: #161616;
                text-shadow: 0 4px #161616, 0 8px #161616, 0 12px #161616, 4px 0 #161616, 4px 4px #161616,
                  4px 8px #161616, 4px 12px #161616;
              }
            }
            &.tabulator-row.tabulator-group {
              cursor: auto;
            }
            &:hover {
              cursor: grab;
            }
            &.tabulator-selected {
              cursor: default;
              .nested-row-container.open {
                cursor: default;
              }
            }
          }
        }
      }
    }
    &.movable-rows.tabulator-block-select {
      .tabulator-tableHolder {
        .tabulator-table {
          .tabulator-row {
            &:hover {
              cursor: grabbing;
              background-color: ${() => theme.mode.dataTable.backgroundColor} !important;
              .tabulator-cell {
                background-color: transparent;
                ${DataTableActions} {
                  display: none;
                }
                &::nth-child(1)::before {
                  display: none;
                }
              }
            }
            &.tabulator-row-placeholder {
              background-color: rgba(0, 117, 190, 0.15);
              &:hover {
                background-color: rgba(0, 117, 190, 0.15) !important;
              }
            }
            &.tabulator-moving {
              background-color: ${() => theme.mode.dataTable.backgroundColor};
              border: 1px solid rgba(0, 117, 190, 0.5) !important;
              border-right: 2px solid rgba(0, 117, 190, 0.5) !important;
              position: absolute !important;
            }
          }
        }
      }
    }
    &:not(.movable-rows) {
      .tabulator-tableHolder {
        height: auto !important;
      }
    }
    &.tabulator-table-editing {
      .tabulator-tableHolder {
        height: auto !important;
      }
    }
  }
`;
