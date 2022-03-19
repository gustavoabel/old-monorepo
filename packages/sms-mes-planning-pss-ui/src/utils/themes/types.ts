export interface ThemeModeConfig {
  colors: {
    primary: string;
    secondary: string;
    lightblue: string;
    error: string;
    success: string;
    warning: string;
    info: string;
    text: string;
    white: string;
    lightgray: string;
    darkgray: string;
    black: string;
    disabled: string;
  };
  body: {
    bgColor: string;
  };
  alert: {
    textColor: string;
    successBorderColor: string;
    successBgColor: string;
    infoBorderColor: string;
    infoBgColor: string;
    warningBorderColor: string;
    warningBgColor: string;
    errorBorderColor: string;
    errorBgColor: string;
  };
  autoComplete: {
    textColor: string;
    textColorItem: string;
    textColorDisabled: string;
    iconColor: string;
    placeholderColor: string;
    borderColor: string;
    borderColorHover: string;
    borderColorActive: string;
    borderColorItem: string;
    borderColorDisabled: string;
    backgroundColor: string;
    backgroundColorActive: string;
    backgroundColorHover: string;
    backgroundColorItem: string;
    backgroundColorDisabled: string;
    backgroundColorOpen: string;
  };
  badge: {
    textColor: string;
    backgroundColor: string;
  };
  button: {
    //primary
    primaryTextColor: string;
    primaryBgColor: string;
    primaryBorderColor: string;
    primaryBgColorHover: string;
    primaryBorderColorHover: string;
    primaryBgColorFocus: string;
    primaryBorderColorFocus: string;
    primaryBgColorActive: string;
    primaryBorderColorActive: string;
    //secondary
    secondaryTextColor: string;
    secondaryBgColor: string;
    secondaryBorderColor: string;
    secondaryBgColorHover: string;
    secondaryBorderColorHover: string;
    secondaryBgColorFocus: string;
    secondaryBorderColorFocus: string;
    secondaryBgColorActive: string;
    secondaryBorderColorActive: string;
    //tertiary
    tertiaryTextColor: string;
    tertiaryBgColor: string;
    tertiaryBorderColor: string;
    tertiaryTextColorHover: string;
    tertiaryBgColorHover: string;
    tertiaryBorderColorHover: string;
    tertiaryTextColorFocus: string;
    tertiaryBgColorFocus: string;
    tertiaryBorderColorFocus: string;
    tertiaryTextColorActive: string;
    tertiaryBgColorActive: string;
    tertiaryBorderColorActive: string;
    //link
    iconColor: string;
    linkTextColor: string;
    linkBgColor: string;
    linkBorderColor: string;
    linkTextColorHover: string;
    linkBgColorHover: string;
    linkBorderColorHover: string;
    linkTextColorFocus: string;
    linkBgColorFocus: string;
    linkBorderColorFocus: string;
    linkTextColorActive: string;
    linkBgColorActive: string;
    linkBorderColorActive: string;
    //danger
    dangerTextColor: string;
    dangerTextGhostColor: string;
    dangerBgColor: string;
    dangerBorderColor: string;
    dangerBgColorHover: string;
    dangerBorderColorHover: string;
    dangerBgColorFocus: string;
    dangerBorderColorFocus: string;
    dangerBgColorActive: string;
    dangerBorderColorActive: string;
    //disabled
    buttonTextColorDisabled: string;
    buttonBgColorDisabled: string;
    buttonBorderColorDisabled: string;
    //text
    textButtonColor: string;
  };
  card: {
    cardBgColor: string;
    cardBorderColor: string;
    descriptionColor: string;
    editCardBgColor: string;
    newCardBgColor: string;
    titleColor: string;
  };
  checkbox: {
    textColor: string;
    textColorDisabled: string;
    borderColor: string;
    borderColorChecked: string;
    borderColorFocused: string;
    borderColorDisabled: string;
    backgroundColor: string;
    backgroundColorChecked: string;
    backgroundColorFocused: string;
    backgroundColorDisabled: string;
  };
  collapse: {
    textColor: string;
    iconColor: string;
    borderColor: string;
    backgroundColor: string;
    backgroundColorActive: string;
    backgroundColorHover: string;
  };
  colorPicker: {
    borderColor: string;
    backgroundColor: string;
  };
  dataList: {
    textColor: string;
    textColorHover: string;
    textColorActive: string;
    iconColor: string;
    iconColorDisabled: string;
    iconColorEnabled: string;
    linkColor: string;
    borderColor: string;
    backgroundColor: string;
    backgroundColorActive: string;
    backgroundColorHover: string;
  };
  dataTable: {
    textColor: string;
    textColorHover: string;
    textColorActive: string;
    iconColor: string;
    iconColorDisabled: string;
    iconColorEnabled: string;
    linkColor: string;
    borderColor: string;
    backgroundColor: string;
    backgroundColorActive: string;
    backgroundColorHover: string;
    filterBorderColor: string;
    filterBackgroundColor: string;
  };
  divider: {
    textColor: string;
    borderColor: string;
    headerBorderColor: string;
  };
  dropDown: {
    textColor: string;
    textColorActive: string;
    textColorHover: string;
    textColorDisabled: string;
    iconColor: string;
    backgroundColor: string;
    backgroundColorActive: string;
    backgroundColorHover: string;
    backgroundColorDisabled: string;
    borderColor: string;
    scrollTrackBgColor: string;
    scrollThumbBgColor: string;
    scrollThumbBorderColor: string;
    scrollThumbBorderColorHover: string;
  };
  empty: {
    iconColor: string;
    textColor: string;
  };
  field: {
    labelColor: string;
    hintColor: string;
    errorColor: string;
    warningColor: string;
    requiredColor: string;
    backgroundColor: string;
  };
  filter: {
    backgroundColor: string;
    borderColor: string;
    inputBackgroundColor: string;
  };
  form: {
    textColor: string;
  };
  gridView: {
    textColor: string;
  };
  icon: {
    iconColor: string;
  };
  inputNumber: {
    textColor: string;
    textColorDisabled: string;
    handlerIconColor: string;
    handlerBackgroundColor: string;
    handlerBackgroundColorActive: string;
    placeholderColor: string;
    placeholderColorDisabled: string;
    borderColor: string;
    borderColorHover: string;
    borderColorActive: string;
    borderColorDisabled: string;
    backgroundColor: string;
    backgroundColorActive: string;
    backgroundColorHover: string;
    backgroundColorDisabled: string;
  };
  inputSearch: {
    textColor: string;
    textColorDisabled: string;
    iconColor: string;
    iconColorDisabled: string;
    placeholderColor: string;
    placeholderColorDisabled: string;
    borderColor: string;
    borderColorHover: string;
    borderColorActive: string;
    borderColorDisabled: string;
    backgroundColor: string;
    backgroundColorActive: string;
    backgroundColorHover: string;
    backgroundColorDisabled: string;
  };
  inputText: {
    textColor: string;
    clearColor: string;
    textColorDisabled: string;
    placeholderColor: string;
    placeholderColorDisabled: string;
    borderColor: string;
    borderColorHover: string;
    borderColorActive: string;
    borderColorDisabled: string;
    backgroundColor: string;
    altBackgroundColor: string;
    backgroundColorActive: string;
    backgroundColorHover: string;
    backgroundColorDisabled: string;
    inverseBackgroundColor: string;
  };
  list: {
    textColor: string;
    titleColor: string;
    descriptionColor: string;
    iconColor: string;
    borderColor: string;
    backgroundColor: string;
    extraBackgroundColor: string;
  };
  menu: {
    textColor: string;
    titleColor: string;
    iconColor: string;
    backgroundColor: string;
  };
  modal: {
    textColor: string;
    titleColor: string;
    iconColor: string;
    backgroundColor: string;
  };
  pagination: {
    textColor: string;
    linkColor: string;
    linkColorActive: string;
    linkColorDisabled: string;
    linkColorFocused: string;
    linkColorHover: string;
    borderColor: string;
    borderColorActive: string;
    borderColorDisabled: string;
    borderColorFocused: string;
    borderColorHover: string;
    backgroundColor: string;
    backgroundColorActive: string;
    backgroundColorDisabled: string;
    backgroundColorFocused: string;
    backgroundColorHover: string;
  };
  pages: {
    textColor: string;
    iconColor: string;
    linkColor: string;
    borderColor: string;
    headerBackgroundColor: string;
    headerBorderColor: string;
    headerTitleColor: string;
    siderBackgroundColor: string;
    imageBackgroundColor: string;
    pageBackgroundColor: string;
  };
  popover: {
    textColor: string;
    textColorHover: string;
    backgroundColor: string;
    backgroundColorHover: string;
    borderColor: string;
  };
  progress: {
    textColor: string;
    iconColor: string;
    barBgColor: string;
    pathBgColor: string;
    successColor: string;
    exceptionColor: string;
  };
  radioButtonOutline: {
    textColor: string;
    textColorHover: string;
    textColorChecked: string;
    textColorDisabled: string;
    borderColor: string;
    borderColorHover: string;
    borderColorChecked: string;
    borderColorActive: string;
    borderColorDisabled: string;
    backgroundColor: string;
    backgroundColorHover: string;
    backgroundColorChecked: string;
    backgroundColorActive: string;
    backgroundColorDisabled: string;
  };
  radioButtonSolid: {
    textColor: string;
    textColorHover: string;
    textColorChecked: string;
    textColorDisabled: string;
    borderColor: string;
    borderColorHover: string;
    borderColorChecked: string;
    borderColorActive: string;
    borderColorDisabled: string;
    backgroundColor: string;
    backgroundColorHover: string;
    backgroundColorChecked: string;
    backgroundColorActive: string;
    backgroundColorDisabled: string;
  };
  radioInput: {
    textColor: string;
    textColorDisabled: string;
    borderColor: string;
    borderColorChecked: string;
    borderColorFocused: string;
    borderColorDisabled: string;
    backgroundColor: string;
    backgroundColorChecked: string;
    backgroundColorFocused: string;
    backgroundColorDisabled: string;
  };
  resizable: {
    textColor: string;
    backgroundColor: string;
    borderColor: string;
  };
  result: {
    titleTextColor: string;
    subtitleTextColor: string;
    iconColor: string;
    infoColor: string;
    successColor: string;
    errorColor: string;
    warningColor: string;
  };
  scroll: {
    thumbBackgroundColor: string;
    thumbBackgroundColorHover: string;
    thumbBorderColor: string;
    trackBackgroundColor: string;
  };
  select: {
    textColor: string;
    backgroundColor: string;
    borderColor: string;
  };
  slider: {
    textColor: string;
    railColor: string;
    railColorDisabled: string;
    railColorHover: string;
    trackColor: string;
    trackColorDisabled: string;
    trackColorFocused: string;
    trackColorHover: string;
    dotColor: string;
    dotColorActive: string;
    dotColorDisabled: string;
    dotColorHover: string;
    handleColor: string;
    handleDragging: string;
    handleColorFocused: string;
    handleColorHover: string;
    handleColorDisabled: string;
  };
  skeleton: {
    iconColor: string;
    backgroundColor: string;
    backgroundColorLoading: string;
  };
  spin: {
    borderColor: string;
    borderTopColor: string;
  };
  splitPanel: {
    textColor: string;
    backgroundColor: string;
  };
  steps: {
    titleColor: string;
    titleColorError: string;
    titleColorWait: string;
    descriptionColor: string;
    descriptionColorError: string;
    iconColorError: string;
    iconColorFinished: string;
    iconColorProgress: string;
    iconColorWait: string;
    barColor: string;
    barColorActive: string;
    borderColorError: string;
    borderColorFinished: string;
    borderColorProgress: string;
    borderColorWait: string;
    backgroundColorFinished: string;
    backgroundColorProgress: string;
    backgroundColorWait: string;
  };
  switchButton: {
    textColor: string;
    textColorChecked: string;
    textColorDisabled: string;
    borderColor: string;
    borderColorFocused: string;
    borderColorDisabled: string;
    backgroundColor: string;
    backgroundColorChecked: string;
    backgroundColorDisabled: string;
    handleColor: string;
    handleColorChecked: string;
    handleColorDisabled: string;
  };
  tabs: {
    textColor: string;
    textColorActive: string;
    backgroundColor: string;
    backgroundColorActive: string;
    barColor: string;
    borderColor: string;
  };
  tag: {
    textColor: string;
    iconColor: string;
  };
  text: {
    textColor: string;
  };
  tooltip: {
    triggerTextColor: string;
    tooltipTextColor: string;
    backgroundColor: string;
  };
  transfer: {
    textColor: string;
    iconColor: string;
    backgroundColor: string;
    headerBackgroundColor: string;
    borderColor: string;
  };
  tree: {
    textColor: string;
    iconColor: string;
    backgroundColor: string;
    backgroundColorSelected: string;
    borderColor: string;
  };
  underConstruction: {
    textColor: string;
    iconColor: string;
    backgroundColor: string;
    borderColor: string;
  };
  upload: {
    textColor: string;
    textColorDisabled: string;
    iconColor: string;
    backgroundColor: string;
    backgroundColorDisabled: string;
    backgroundColorHover: string;
    borderColor: string;
    borderColorDisabled: string;
  };
  valuePicker: {
    textColor: string;
    textColorDisabled: string;
    iconColor: string;
    iconColorDisabled: string;
    placeholderColor: string;
    placeholderColorDisabled: string;
    borderColor: string;
    borderColorHover: string;
    borderColorActive: string;
    borderColorDisabled: string;
    backgroundColor: string;
    altBackgroundColor: string;
    backgroundColorActive: string;
    backgroundColorHover: string;
    backgroundColorDisabled: string;
    backgroundColorOpen: string;
  };
  view: {
    backgroundColor: string;
    borderColor: string;
  };
  widget: {
    titleColor: string;
    textColor: string;
    borderColor: string;
    backgroundColor: string;
    altbackgroundColor: string;
  };
}

export interface ThemeLayoutConfig {
  height: {
    lg: string | number;
    md: string | number;
    sm: string | number;
    xs: string | number;
    xss: string | number;
  };
  width: {
    lg: string | number;
    md: string | number;
    sm: string | number;
    xs: string | number;
    xss: string | number;
  };
  margin: {
    lg: string | number;
    md: string | number;
    sm: string | number;
    xs: string | number;
    xss: string | number;
  };
  padding: {
    lg: string | number;
    md: string | number;
    sm: string | number;
    xs: string | number;
    xss: string | number;
  };
  alert: {
    fontSize: string | number;
    iconSize: string | number;
    borderWidth: string | number;
    borderLeftWidth: string | number;
  };
  autoComplete: {
    fontSize: string | number;
    iconSize: string | number;
    wrapperHeight: string | number;
    wrapperLineHeight: string | number;
    inputHeight: string | number;
    inputLineHeight: string | number;
    itemHeight: string | number;
    itemLineHeight: string | number;
  };
  badge: {
    fontSize: string;
    height: string;
    lineHeight: string;
    width: string;
  };
  button: {
    fontSize: string | number;
    iconSize: string | number;
    iconButtonWidth: string | number;
    buttonHeight: string | number;
    buttonPadding: string | number;
  };
  card: {
    descriptionSize: string;
    iconSize: string;
    padding: string;
    titleSize: string;
  };
  checkbox: {
    fontSize: string | number;
    wrapperHeight: string | number;
    wrapperLineHeight: string | number;
  };
  collapse: {
    fontSize: string;
    iconSize: string;
    collapseHeight: string;
  };
  colorPicker: {
    pickerHeight: string | number;
    pickerWidth: string | number;
    pickerMargin: string | number;
  };
  dataList: {
    fontSize: string | number;
    iconSize: string | number;
    height: string | number;
    lineHeight: string | number;
    width: string | number;
    padding: string | number;
  };
  dataTable: {
    fontSize: string | number;
    iconSize: string | number;
    height: string | number;
    lineHeight: string | number;
    padding: string | number;
    toolbarHeight: string | number;
  };
  divider: {
    fontSize: string | number;
    height: string | number;
  };
  dropDown: {
    fontSize: string | number;
    iconSize: string | number;
    itemHeight: string | number;
    itemLineHeight: string | number;
  };
  empty: {
    fontSize: string | number;
    iconSize: string | number;
    margin: string | number;
  };
  field: {
    height: string | number;
  };
  filter: {
    fontSize: string | number;
  };
  form: {
    fontSize: string | number;
  };
  gridView: {
    fontSize: string | number;
    padding: string | number;
  };
  header: {
    fontSize: string | number;
    iconSize: string | number;
  };
  icon: {
    iconSize: string | number;
  };
  inputNumber: {
    fontSize: string | number;
    iconSize: string | number;
    handlerIconSize: string | number;
    height: string | number;
    lineHeight: string | number;
    padding: string | number;
  };
  inputSearch: {
    fontSize: string | number;
    iconSize: string | number;
    height: string | number;
    lineHeight: string | number;
    padding: string | number;
  };
  inputText: {
    fontSize: string | number;
    iconSize: string | number;
    height: string | number;
    lineHeight: string | number;
  };
  list: {
    fontSize: string | number;
    titleSize: string | number;
    iconSize: string | number;
    height: string | number;
  };
  menu: {
    titleSize: string | number;
    fontSize: string | number;
    iconSize: string | number;
    titleHeight: string | number;
    itemHeight: string | number;
    iconWidth: string | number;
  };
  modal: {
    fontSize: string | number;
    iconSize: string | number;
    height: string | number;
  };
  pages: {
    fontSize: string | number;
    headerFontSize: string | number;
    imageTitleSize: string | number;
    imageSubtitleSize: string | number;
    siderTitleSize: string | number;
    padding: string | number;
    margin: string | number;
    headerHeight: string | number;
  };
  pagination: {
    fontSize: string | number;
    iconSize: string | number;
    height: string | number;
    width: string | number;
  };
  popover: {
    fontSize: string | number;
    height: string | number;
  };
  progress: {
    fontSize: string | number;
    iconSize: string | number;
    height: string | number;
    width: string | number;
    margin: string | number;
  };
  radioButton: {
    fontSize: string | number;
    wrapperHeight: string | number;
    wrapperLineHeight: string | number;
  };
  radioInput: {
    fontSize: string | number;
    wrapperHeight: string | number;
    wrapperLineHeight: string | number;
  };
  result: {
    titleFontSize: string | number;
    subtitleFontSize: string | number;
    iconSize: string | number;
    margin: string | number;
  };
  scroll: {
    height: string | number;
    width: string | number;
  };
  select: {
    fontSize: string | number;
    height: string | number;
    lineHeight: string | number;
  };
  skeleton: {
    height: string | number;
    width: string | number;
    lineHeight: string | number;
    margin: string | number;
    padding: string | number;
  };
  space: {
    fontSize: string | number;
  };
  spin: {
    fontSize: string | number;
    iconSize: string | number;
  };
  splitPanel: {
    fontSize: string | number;
  };
  steps: {
    barTop: string | number;
    titleSize: string | number;
    descriptionSize: string | number;
    iconSize: string | number;
    height: string | number;
    width: string | number;
    margin: string | number;
    padding: string | number;
  };
  switchButton: {
    fontSize: string | number;
    buttonHeight: string | number;
    buttonLineHeight: string | number;
    handleSize: string | number;
  };
  tabs: {
    barSize: string | number;
    iconSize: string | number;
    fontSize: string | number;
    padding: string | number;
    margin: string | number;
    height: string | number;
    width: string | number;
    lineHeight: string | number;
  };
  text: {
    fontSize: string | number;
  };
  tooltip: {
    fontSize: string | number;
    height: string | number;
    width: string | number;
  };
  transfer: {
    fontSize: string | number;
    iconSize: string | number;
    height: string | number;
    lineHeight: string | number;
  };
  tree: {
    fontSize: string | number;
    iconSize: string | number;
    borderSize: string | number;
    height: string | number;
  };
  underConstruction: {
    fontSize: string | number;
    iconSize: string;
    height: string | number;
    width: string | number;
    margin: string | number;
    padding: string | number;
  };
  upload: {
    fontSize: string | number;
    iconSize: string;
    height: string | number;
    width: string | number;
    margin: string | number;
  };
  valuePicker: {
    fontSize: string | number;
    iconSize: string | number;
    iconRight: string | number;
    wrapperHeight: string | number;
    wrapperLineHeight: string | number;
    inputHeight: string | number;
    inputLineHeight: string | number;
    padding: string | number;
  };
  widget: {
    fontSize: string | number;
    iconSize: string | number;
    padding: string | number;
    margin: string | number;
  };
  typography: {
    paragraph: {
      fontSize: string | number;
      marginBottom: string | number;
    };
    title: {
      fontSize: string | number;
      marginBottom: string | number;
    };
    text: {
      fontSize: string | number;
      marginBottom: string | number;
    };
  };
}
