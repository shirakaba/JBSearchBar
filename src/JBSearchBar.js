import React from 'react';
import { NativeModules, requireNativeComponent, findNodeHandle } from 'react-native';

const JBSearchBar = requireNativeComponent('JBSearchBar', null);

class SearchBar extends React.PureComponent {
  static defaultProps = {
    text: '',
    placeholder: 'Search',
    barStyle: 'default',
    searchBarStyle: 'default',
    editable: true,
    cancelButtonText: 'Cancel',
    showsCancelButton: false,
    hideBackground: false,
    enablesReturnKeyAutomatically: true,
    textFieldBackgroundColor: null,
    tintColor: null,
    barTintColor: null,
    textColor: null,
    returnKeyType: 'search',
    keyboardType: 'default',
    keyboardAppearance: 'default',
    autoCapitalize: 'sentences',
    autoCorrect: false,
    spellCheck: false,
    showsCancelButtonWhileEditing: true,
    onChange: (e) => null,
    onChangeText: (text) => null,
    onFocus: () => null,
    onBlur: () => null,
    onSearchButtonPress: (text) => null,
    onCancelButtonPress: () => null,
  }

  onChange = (e) => {
    this.props.onChange(e)
    this.props.onChangeText(e.nativeEvent.text)
  }

  onSearchButtonPress = (e) => {
    this.props.onSearchButtonPress(e.nativeEvent.searchText)
  }

  onFocus = () => {
    if (this.props.showsCancelButtonWhileEditing) {
      NativeModules.JBSearchBarManager.toggleCancelButton(findNodeHandle(this), true)
    }

    this.props.onFocus()
  }

  onCancelButtonPress = () => {
    if (this.props.showsCancelButtonWhileEditing) {
      NativeModules.JBSearchBarManager.toggleCancelButton(findNodeHandle(this), false)
    }

    this.props.onChangeText('')
    this.props.onCancelButtonPress()
  }

  onBlur = () => {
    if (this.props.showsCancelButtonWhileEditing) {
      NativeModules.JBSearchBarManager.toggleCancelButton(findNodeHandle(this), false)
    }

    this.props.onBlur()
  }

  blur() {
    return NativeModules.JBSearchBarManager.blur(findNodeHandle(this))
  }

  focus() {
    return NativeModules.JBSearchBarManager.focus(findNodeHandle(this))
  }

  clearText() {
    return NativeModules.JBSearchBarManager.clearText(findNodeHandle(this))
  }

  unFocus() {
    return NativeModules.JBSearchBarManager.unFocus(findNodeHandle(this))
  }

  render() {
    return (
      <JBSearchBar
        style={{ height: NativeModules.JBSearchBarManager.ComponentHeight }}
        {...this.props}
        onChange={this.onChange}
        // onPress={this.onPress}
        onFocus={this.onFocus}
        onBlur={this.onBlur}
        onSearchButtonPress={this.onSearchButtonPress}
        onCancelButtonPress={this.onCancelButtonPress}
      />
    )
  }
}

export default SearchBar