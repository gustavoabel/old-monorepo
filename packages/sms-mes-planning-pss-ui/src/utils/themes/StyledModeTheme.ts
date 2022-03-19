import Color from 'color';

import { ThemeModeConfig } from './types';

const light: ThemeModeConfig = {
  colors: {
    primary: '#0075be',
    secondary: '#7c7c7c',
    lightblue: '#e6f7ff',
    error: '#e3000f',
    success: '#24a148',
    warning: '#f1c21b',
    info: '#00539a',
    text: '#161616',
    white: '#fff',
    lightgray: '#f4f4f4',
    darkgray: '#161616',
    black: '#000',
    disabled: '#c6c6c6',
  },
  body: {
    bgColor: '#fff',
  },
  alert: {
    get textColor() {
      return light.colors.text;
    },
    get successBorderColor() {
      return light.colors.success;
    },
    get successBgColor() {
      return Color(light.colors.success).fade(0.9).toString();
    },
    get infoBorderColor() {
      return light.colors.info;
    },
    get infoBgColor() {
      return Color(light.colors.info).fade(0.9).toString();
    },
    get warningBorderColor() {
      return light.colors.warning;
    },
    get warningBgColor() {
      return Color(light.colors.warning).fade(0.9).toString();
    },
    get errorBorderColor() {
      return light.colors.error;
    },
    get errorBgColor() {
      return Color(light.colors.error).fade(0.9).toString();
    },
  },
  autoComplete: {
    get textColor() {
      return light.colors.text;
    },
    get textColorItem() {
      return light.colors.white;
    },
    textColorDisabled: '#c6c6c6',
    iconColor: '#393939',
    placeholderColor: '#8d8d8d',
    borderColor: '#8d8d8d',
    borderColorHover: '#8d8d8d',
    get borderColorActive() {
      return light.colors.primary;
    },
    get borderColorItem() {
      return light.colors.primary;
    },
    borderColorDisabled: 'transparent',
    get backgroundColor() {
      return light.colors.lightgray;
    },
    get backgroundColorActive() {
      return light.colors.lightgray;
    },
    get backgroundColorHover() {
      return light.colors.lightgray;
    },
    get backgroundColorItem() {
      return light.colors.primary;
    },
    get backgroundColorDisabled() {
      return light.colors.lightgray;
    },
    backgroundColorOpen: '#e0e0e0',
  },
  badge: {
    get textColor() {
      return light.colors.text;
    },
    backgroundColor: '#ffb329',
  },
  button: {
    //.ant-btn-primary
    get primaryTextColor() {
      return light.colors.white;
    },
    get primaryBgColor() {
      return light.colors.primary;
    },
    get primaryBorderColor() {
      return light.colors.primary;
    },
    primaryBgColorHover: '#00539a',
    primaryBorderColorHover: '#00539a',
    get primaryBgColorFocus() {
      return light.colors.primary;
    },
    primaryBorderColorFocus: '#00539a',
    primaryBgColorActive: '#003a6d',
    primaryBorderColorActive: '#003a6d',
    //.ant-btn (only the default button class is necessary)
    get secondaryTextColor() {
      return light.colors.white;
    },
    secondaryBgColor: '#393939',
    secondaryBorderColor: '#393939',
    secondaryBgColorHover: '#4c4c4c',
    secondaryBorderColorHover: '#4c4c4c',
    secondaryBgColorFocus: '#393939',
    get secondaryBorderColorFocus() {
      return light.colors.primary;
    },
    secondaryBgColorActive: '#6f6f6f',
    secondaryBorderColorActive: '#6f6f6f',
    //.ant-btn-background-ghost
    get tertiaryTextColor() {
      return light.colors.primary;
    },
    tertiaryBgColor: 'transparent',
    get tertiaryBorderColor() {
      return light.colors.primary;
    },
    get tertiaryTextColorHover() {
      return light.colors.white;
    },
    get tertiaryBgColorHover() {
      return light.colors.primary;
    },
    get tertiaryBorderColorHover() {
      return light.colors.primary;
    },
    get tertiaryTextColorFocus() {
      return light.colors.white;
    },
    get tertiaryBgColorFocus() {
      return light.colors.primary;
    },
    tertiaryBorderColorFocus: '#00539a',
    get tertiaryTextColorActive() {
      return light.colors.white;
    },
    tertiaryBgColorActive: '#003a6d',
    tertiaryBorderColorActive: '#003a6d',
    //.ant-btn-link
    get iconColor() {
      return light.colors.primary;
    },
    get linkTextColor() {
      return light.colors.primary;
    },
    linkBgColor: 'transparent',
    linkBorderColor: 'transparent',
    get linkTextColorHover() {
      return light.colors.primary;
    },
    linkBgColorHover: 'transparent',
    linkBorderColorHover: 'transparent',
    get linkTextColorFocus() {
      return light.colors.primary;
    },
    linkBgColorFocus: 'transparent',
    get linkBorderColorFocus() {
      return 'transparent';
    },
    get linkTextColorActive() {
      return light.colors.primary;
    },
    linkBgColorActive: 'transparent',
    linkBorderColorActive: 'transparent',
    //.ant-btn-dangerous
    get dangerTextColor() {
      return light.colors.white;
    },
    get dangerTextGhostColor() {
      return light.colors.error;
    },
    get dangerBgColor() {
      return light.colors.error;
    },
    get dangerBorderColor() {
      return light.colors.error;
    },
    dangerBgColorHover: '#ba1b23',
    dangerBorderColorHover: '#ba1b23',
    get dangerBgColorFocus() {
      return light.colors.error;
    },
    get dangerBorderColorFocus() {
      return light.colors.primary;
    },
    dangerBgColorActive: '#750e13',
    dangerBorderColorActive: '#750e13',
    //.ant-btn-text
    get textButtonColor() {
      return light.colors.text;
    },
    //disabled
    buttonTextColorDisabled: '#8d8d8d',
    buttonBgColorDisabled: '#c6c6c6',
    buttonBorderColorDisabled: '#c6c6c6',
  },
  card: {
    get cardBgColor() {
      return light.colors.white;
    },
    cardBorderColor: '#e0e0e0',
    descriptionColor: '##6f6f6f',
    get editCardBgColor() {
      return light.colors.lightgray;
    },
    get newCardBgColor() {
      return light.colors.white;
    },
    get titleColor() {
      return light.colors.text;
    },
  },
  checkbox: {
    get textColor() {
      return light.colors.text;
    },
    textColorDisabled: '#8d8d8d',
    get borderColor() {
      return light.colors.darkgray;
    },
    get borderColorChecked() {
      return light.colors.primary;
    },
    get borderColorFocused() {
      return light.colors.primary;
    },
    borderColorDisabled: '#c6c6c6',
    backgroundColor: 'transparent',
    get backgroundColorChecked() {
      return light.colors.primary;
    },
    backgroundColorFocused: 'transparent',
    get backgroundColorDisabled() {
      return light.colors.lightgray;
    },
  },
  collapse: {
    get textColor() {
      return light.colors.text;
    },
    iconColor: '#393939',
    borderColor: '#e0e0e0',
    get backgroundColor() {
      return light.colors.white;
    },
    backgroundColorActive: '#e0e0e0',
    get backgroundColorHover() {
      return light.colors.lightgray;
    },
  },
  colorPicker: {
    borderColor: '#e0e0e0',
    get backgroundColor() {
      return light.colors.lightgray;
    },
  },
  dataTable: {
    textColor: '#393939',
    get textColorHover() {
      return light.colors.text;
    },
    get textColorActive() {
      return light.colors.text;
    },
    get iconColor() {
      return light.colors.darkgray;
    },
    iconColorDisabled: '#c6c6c6',
    get iconColorEnabled() {
      return light.colors.primary;
    },
    get linkColor() {
      return light.colors.primary;
    },
    borderColor: '#e0e0e0',
    backgroundColor: '#ffffff',
    backgroundColorActive: '#e0e0e0',
    get backgroundColorHover() {
      return light.colors.lightgray;
    },
    filterBorderColor: '#e0e0e0',
    filterBackgroundColor: '#f4f4f4',
  },
  dataList: {
    textColor: '#393939',
    get textColorHover() {
      return light.colors.text;
    },
    get textColorActive() {
      return light.colors.text;
    },
    get iconColor() {
      return light.colors.darkgray;
    },
    iconColorDisabled: '#c6c6c6',
    get iconColorEnabled() {
      return light.colors.primary;
    },
    get linkColor() {
      return light.colors.primary;
    },
    get borderColor() {
      return light.colors.white;
    },
    get backgroundColor() {
      return light.colors.lightgray;
    },
    backgroundColorActive: '#e0e0e0',
    get backgroundColorHover() {
      return light.colors.lightgray;
    },
  },
  divider: {
    get textColor() {
      return light.colors.text;
    },
    borderColor: '#e0e0e0',
    headerBorderColor: '#e0e0e0',
  },
  dropDown: {
    textColor: '#393939',
    get textColorActive() {
      return light.colors.text;
    },
    textColorHover: '#393939',
    textColorDisabled: '#c6c6c6',
    iconColor: '#393939',
    get backgroundColor() {
      return light.colors.lightgray;
    },
    backgroundColorActive: '#e0e0e0',
    backgroundColorHover: '#e0e0e0',
    get backgroundColorDisabled() {
      return light.colors.lightgray;
    },
    borderColor: '#e0e0e0',
    get scrollTrackBgColor() {
      return light.colors.lightgray;
    },
    scrollThumbBgColor: '#c6c6c6',
    get scrollThumbBorderColor() {
      return light.colors.lightgray;
    },
    scrollThumbBorderColorHover: '#a8a8a8',
  },
  empty: {
    get iconColor() {
      return light.colors.darkgray;
    },
    textColor: '#6f6f6f',
  },
  filter: {
    backgroundColor: '#f4f4f4',
    borderColor: '#e0e0e0',
    inputBackgroundColor: '#fff',
  },
  form: {
    get textColor() {
      return light.colors.text;
    },
  },
  gridView: {
    get textColor() {
      return light.colors.text;
    },
  },
  icon: {
    get iconColor() {
      return light.colors.darkgray;
    },
  },
  inputNumber: {
    textColor: '#8d8d8d',
    textColorDisabled: '#c6c6c6',
    handlerIconColor: '#393939',
    handlerBackgroundColor: 'transparent',
    handlerBackgroundColorActive: '#e0e0e0',
    placeholderColor: '#8d8d8d',
    placeholderColorDisabled: '#c6c6c6',
    borderColor: '#8d8d8d',
    borderColorHover: '#8d8d8d',
    get borderColorActive() {
      return light.colors.primary;
    },
    borderColorDisabled: 'transparent',
    get backgroundColor() {
      return light.colors.lightgray;
    },
    get backgroundColorActive() {
      return light.colors.lightgray;
    },
    get backgroundColorHover() {
      return light.colors.lightgray;
    },
    get backgroundColorDisabled() {
      return light.colors.lightgray;
    },
  },
  inputSearch: {
    get textColor() {
      return light.colors.text;
    },
    textColorDisabled: '#c6c6c6',
    iconColor: '#a8a8a8',
    iconColorDisabled: '#c6c6c6',
    placeholderColor: '#8d8d8d',
    placeholderColorDisabled: '#c6c6c6',
    borderColor: '#8d8d8d',
    borderColorHover: '#8d8d8d',
    get borderColorActive() {
      return light.colors.primary;
    },
    borderColorDisabled: 'transparent',
    get backgroundColor() {
      return light.colors.lightgray;
    },
    get backgroundColorActive() {
      return light.colors.lightgray;
    },
    get backgroundColorHover() {
      return light.colors.lightgray;
    },
    get backgroundColorDisabled() {
      return light.colors.lightgray;
    },
  },
  inputText: {
    get textColor() {
      return light.colors.text;
    },
    clearColor: '#a8a8a8',
    textColorDisabled: '#c6c6c6',
    placeholderColor: '#8d8d8d',
    placeholderColorDisabled: '#c6c6c6',
    borderColor: '#8d8d8d',
    borderColorHover: '#8d8d8d',
    get borderColorActive() {
      return light.colors.primary;
    },
    borderColorDisabled: 'transparent',
    get backgroundColor() {
      return light.colors.lightgray;
    },
    altBackgroundColor: '#fff',
    get backgroundColorActive() {
      return light.colors.lightgray;
    },
    get backgroundColorHover() {
      return light.colors.lightgray;
    },
    get backgroundColorDisabled() {
      return light.colors.lightgray;
    },
    get inverseBackgroundColor() {
      return light.colors.white;
    },
  },
  list: {
    get textColor() {
      return light.colors.text;
    },
    get titleColor() {
      return light.colors.primary;
    },
    descriptionColor: '#6f6f6f',
    iconColor: '#393939',
    borderColor: '#e0e0e0',
    get backgroundColor() {
      return light.colors.lightgray;
    },
    get extraBackgroundColor() {
      return light.colors.white;
    },
  },
  menu: {
    get textColor() {
      return light.colors.white;
    },
    get titleColor() {
      return light.colors.white;
    },
    get iconColor() {
      return light.colors.white;
    },
    get backgroundColor() {
      return light.colors.primary;
    },
  },
  modal: {
    get textColor() {
      return light.colors.text;
    },
    get titleColor() {
      return light.colors.primary;
    },
    get iconColor() {
      return light.colors.darkgray;
    },
    get backgroundColor() {
      return light.colors.white;
    },
  },
  pagination: {
    get textColor() {
      return light.colors.text;
    },
    linkColor: '#393939',
    get linkColorActive() {
      return light.colors.text;
    },
    linkColorDisabled: '#c6c6c6',
    get linkColorFocused() {
      return light.colors.text;
    },
    get linkColorHover() {
      return light.colors.text;
    },
    borderColor: '#e0e0e0',
    borderColorActive: 'transparent',
    get borderColorDisabled() {
      return light.colors.lightgray;
    },
    borderColorFocused: '#00539A',
    borderColorHover: '#e0e0e0',
    get backgroundColor() {
      return light.colors.lightgray;
    },
    backgroundColorActive: '#e0e0e0',
    get backgroundColorDisabled() {
      return light.colors.lightgray;
    },
    backgroundColorFocused: '#e0e0e0',
    backgroundColorHover: '#e0e0e0',
  },
  field: {
    labelColor: '#393939',
    hintColor: '#a8a8a8',
    get errorColor() {
      return light.colors.error;
    },
    get warningColor() {
      return light.colors.warning;
    },
    requiredColor: '#8d8d8d',
    get backgroundColor() {
      return light.colors.lightgray;
    },
  },
  pages: {
    get textColor() {
      return light.colors.text;
    },
    iconColor: '#161616',
    get linkColor() {
      return light.colors.primary;
    },
    borderColor: '#e0e0e0',
    get headerBackgroundColor() {
      return light.colors.lightgray;
    },
    headerBorderColor: '#e0e0e0',
    get headerTitleColor() {
      return light.colors.text;
    },
    get siderBackgroundColor() {
      return light.colors.white;
    },
    get imageBackgroundColor() {
      return light.colors.lightgray;
    },
    pageBackgroundColor: '#e0e0e0',
  },
  popover: {
    textColor: '#393939',
    get textColorHover() {
      return light.colors.text;
    },
    get backgroundColor() {
      return light.colors.white;
    },
    backgroundColorHover: '#e0e0e0',
    borderColor: '#e0e0e0',
  },
  progress: {
    get textColor() {
      return light.colors.text;
    },
    get iconColor() {
      return light.colors.darkgray;
    },
    get barBgColor() {
      return light.colors.lightgray;
    },
    get pathBgColor() {
      return light.colors.primary;
    },
    get successColor() {
      return light.colors.success;
    },
    get exceptionColor() {
      return light.colors.error;
    },
  },
  radioButtonOutline: {
    textColor: '#393939',
    get textColorHover() {
      return light.colors.text;
    },
    get textColorChecked() {
      return light.colors.white;
    },
    textColorDisabled: '#8d8d8d',
    borderColor: '#e0e0e0',
    get borderColorHover() {
      return light.colors.lightgray;
    },
    get borderColorChecked() {
      return light.colors.primary;
    },
    get borderColorActive() {
      return light.colors.primary;
    },
    borderColorDisabled: '#c6c6c6',
    backgroundColor: 'transparent',
    get backgroundColorHover() {
      return light.colors.lightgray;
    },
    get backgroundColorChecked() {
      return light.colors.primary;
    },
    backgroundColorActive: 'transparent',
    get backgroundColorDisabled() {
      return light.colors.lightgray;
    },
  },
  radioButtonSolid: {
    textColor: '#393939',
    get textColorHover() {
      return light.colors.text;
    },
    get textColorChecked() {
      return light.colors.white;
    },
    textColorDisabled: '#8d8d8d',
    borderColor: '#e0e0e0',
    get borderColorHover() {
      return light.colors.lightgray;
    },
    get borderColorChecked() {
      return light.colors.primary;
    },
    get borderColorActive() {
      return light.colors.primary;
    },
    borderColorDisabled: '#c6c6c6',
    backgroundColor: 'transparent',
    get backgroundColorHover() {
      return light.colors.lightgray;
    },
    get backgroundColorChecked() {
      return light.colors.primary;
    },
    backgroundColorActive: 'transparent',
    get backgroundColorDisabled() {
      return light.colors.lightgray;
    },
  },
  radioInput: {
    get textColor() {
      return light.colors.text;
    },
    textColorDisabled: '#8d8d8d',
    get borderColor() {
      return light.colors.darkgray;
    },
    get borderColorChecked() {
      return light.colors.primary;
    },
    get borderColorFocused() {
      return light.colors.primary;
    },
    borderColorDisabled: '#c6c6c6',
    backgroundColor: 'transparent',
    get backgroundColorChecked() {
      return light.colors.primary;
    },
    backgroundColorFocused: 'transparent',
    get backgroundColorDisabled() {
      return light.colors.lightgray;
    },
  },
  resizable: {
    get textColor() {
      return light.colors.text;
    },
    get backgroundColor() {
      return light.colors.white;
    },
    borderColor: '#e0e0e0',
  },
  result: {
    get titleTextColor() {
      return light.colors.text;
    },
    subtitleTextColor: '#6f6f6f',
    get iconColor() {
      return light.colors.darkgray;
    },
    get infoColor() {
      return light.colors.info;
    },
    get successColor() {
      return light.colors.success;
    },
    get errorColor() {
      return light.colors.error;
    },
    get warningColor() {
      return light.colors.warning;
    },
  },
  scroll: {
    thumbBackgroundColor: '#a8a8a8',
    thumbBackgroundColorHover: '#8d8d8d',
    thumbBorderColor: '#f4f4f4',
    trackBackgroundColor: '#f4f4f4',
  },
  select: {
    get textColor() {
      return light.colors.text;
    },
    get backgroundColor() {
      return light.colors.lightgray;
    },
    borderColor: '#8d8d8d',
  },
  slider: {
    get textColor() {
      return light.colors.text;
    },
    get railColor() {
      return light.colors.lightgray;
    },
    get railColorDisabled() {
      return light.colors.lightgray;
    },
    railColorHover: '#e0e0e0',
    get trackColor() {
      return light.colors.primary;
    },
    trackColorDisabled: '#c6c6c6',
    get trackColorFocused() {
      return light.colors.primary;
    },
    get trackColorHover() {
      return light.colors.primary;
    },
    get dotColor() {
      return light.colors.white;
    },
    get dotColorActive() {
      return light.colors.primary;
    },
    get dotColorDisabled() {
      return light.colors.lightgray;
    },
    get dotColorHover() {
      return light.colors.primary;
    },
    handleColor: '#8d8d8d',
    get handleDragging() {
      return light.colors.primary;
    },
    get handleColorFocused() {
      return light.colors.primary;
    },
    get handleColorHover() {
      return light.colors.primary;
    },
    handleColorDisabled: '#c6c6c6',
  },
  skeleton: {
    get iconColor() {
      return light.colors.text;
    },
    get backgroundColor() {
      return light.colors.lightgray;
    },
    backgroundColorLoading: '#e4e4e4',
  },
  spin: {
    get borderColor() {
      return Color(light.colors.white).fade(0.75).toString();
    },
    get borderTopColor() {
      return light.colors.white;
    },
  },
  splitPanel: {
    get textColor() {
      return light.colors.text;
    },
    get backgroundColor() {
      return light.colors.white;
    },
  },
  steps: {
    get titleColor() {
      return light.colors.text;
    },
    get titleColorError() {
      return light.colors.error;
    },
    titleColorWait: '#6f6f6f',
    descriptionColor: '#6f6f6f',
    get descriptionColorError() {
      return light.colors.error;
    },
    get iconColorError() {
      return light.colors.error;
    },
    get iconColorFinished() {
      return light.colors.white;
    },
    get iconColorProgress() {
      return light.colors.primary;
    },
    iconColorWait: '#8d8d8d',
    barColor: '#e0e0e0',
    get barColorActive() {
      return light.colors.primary;
    },
    get borderColorError() {
      return light.colors.error;
    },
    get borderColorFinished() {
      return light.colors.primary;
    },
    get borderColorProgress() {
      return light.colors.primary;
    },
    borderColorWait: '#c6c6c6',
    get backgroundColorFinished() {
      return light.colors.primary;
    },
    get backgroundColorProgress() {
      return light.colors.white;
    },
    backgroundColorWait: '#c6c6c6',
  },
  switchButton: {
    get textColor() {
      return light.colors.white;
    },
    get textColorChecked() {
      return light.colors.white;
    },
    textColorDisabled: '#8d8d8d',
    borderColor: 'transparent',
    get borderColorFocused() {
      return light.colors.primary;
    },
    borderColorDisabled: '#c6c6c6',
    backgroundColor: '#8d8d8d',
    get backgroundColorChecked() {
      return light.colors.primary;
    },
    backgroundColorDisabled: '#c6c6c6',
    get handleColor() {
      return light.colors.lightgray;
    },
    get handleColorChecked() {
      return light.colors.white;
    },
    handleColorDisabled: '#8d8d8d',
  },
  tabs: {
    textColor: '#6f6f6f',
    get textColorActive() {
      return light.colors.text;
    },
    get backgroundColor() {
      return light.colors.white;
    },
    get backgroundColorActive() {
      return light.colors.primary;
    },
    get barColor() {
      return light.colors.primary;
    },
    borderColor: '#e0e0e0',
  },
  tag: {
    get textColor() {
      return light.colors.white;
    },
    get iconColor() {
      return light.colors.white;
    },
  },
  text: {
    get textColor() {
      return light.colors.text;
    },
  },
  tooltip: {
    get triggerTextColor() {
      return light.colors.text;
    },
    get tooltipTextColor() {
      return light.colors.lightgray;
    },
    backgroundColor: 'rgba(22, 22, 22, 0.9)',
  },
  transfer: {
    get textColor() {
      return light.colors.text;
    },
    iconColor: '#a8a8a8',
    get backgroundColor() {
      return light.colors.white;
    },
    get headerBackgroundColor() {
      return light.colors.lightgray;
    },
    borderColor: '#e0e0e0',
  },
  tree: {
    get textColor() {
      return light.colors.text;
    },
    iconColor: '#393939',
    get backgroundColor() {
      return light.colors.lightgray;
    },
    backgroundColorSelected: '#e0e0e0',
    get borderColor() {
      return light.colors.white;
    },
  },
  underConstruction: {
    textColor: '#6f6f6f',
    get iconColor() {
      return light.colors.darkgray;
    },
    get backgroundColor() {
      return light.colors.lightgray;
    },
    borderColor: '#8d8d8d',
  },
  upload: {
    get textColor() {
      return light.colors.text;
    },
    textColorDisabled: '#c6c6c6',
    get iconColor() {
      return light.colors.lightgray;
    },
    get backgroundColor() {
      return light.colors.lightgray;
    },
    get backgroundColorDisabled() {
      return light.colors.lightgray;
    },
    get backgroundColorHover() {
      return Color(light.colors.primary).fade(0.25).toString();
    },
    borderColor: '#e0e0e0',
    borderColorDisabled: 'transparent',
  },
  valuePicker: {
    get textColor() {
      return light.colors.text;
    },
    textColorDisabled: '#c6c6c6',
    iconColor: '#a8a8a8',
    iconColorDisabled: '#c6c6c6',
    placeholderColor: '#8d8d8d',
    placeholderColorDisabled: '#c6c6c6',
    borderColor: '#8d8d8d',
    borderColorHover: '#8d8d8d',
    get borderColorActive() {
      return light.colors.primary;
    },
    borderColorDisabled: 'transparent',
    get backgroundColor() {
      return light.colors.lightgray;
    },
    get altBackgroundColor() {
      return light.colors.lightgray;
    },
    get backgroundColorActive() {
      return light.colors.lightgray;
    },
    get backgroundColorHover() {
      return light.colors.lightgray;
    },
    get backgroundColorDisabled() {
      return light.colors.lightgray;
    },
    backgroundColorOpen: '#e0e0e0',
  },
  view: {
    backgroundColor: '#f4f4f4',
    borderColor: '#e0e0e0',
  },
  widget: {
    get titleColor() {
      return light.colors.primary;
    },
    get textColor() {
      return light.colors.text;
    },
    get backgroundColor() {
      return light.colors.white;
    },
    borderColor: '#e0e0e0',
    get altbackgroundColor() {
      return light.colors.white;
    },
  },
};

export default light;
