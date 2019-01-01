//
//  JBSearchBarManager.m
//  LinguaBrowse
//
//  Created by jamie on 31/12/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>
// #import "JBSearchBar.h"

//@implementation RCTConvert (UIBarStyle)
//RCT_ENUM_CONVERTER(UIBarStyle, (@{
//                                  @"default": @(UIBarStyleDefault),
//                                  @"black": @(UIBarStyleBlack)
//                                  }),
//                   UIBarStyleDefault, integerValue)
//@end
//
//@implementation RCTConvert (UISearchBarStyle)
//RCT_ENUM_CONVERTER(UISearchBarStyle, (@{
//                                        @"default": @(UISearchBarStyleDefault),
//                                        @"prominent": @(UISearchBarStyleProminent),
//                                        @"minimal": @(UISearchBarStyleMinimal)
//                                        }),
//                   UISearchBarStyleDefault, integerValue)
//@end

// https://teabreak.e-spres-oh.com/swift-in-react-native-the-ultimate-guide-part-2-ui-components-907767123d9e
// "If the exposed name ends with Manager, React Native will automatically remove the Manager ending."
@interface RCT_EXTERN_MODULE(JBSearchBarManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(onSearchButtonPress, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onCancelButtonPress, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(placeholder, NSString)
RCT_EXPORT_VIEW_PROPERTY(text, NSString)
//RCT_CUSTOM_VIEW_PROPERTY(showsCancelButton, BOOL, JBSearchBar)
//{
//  BOOL value = [RCTConvert BOOL:json];
//  view.showsCancelButton = value;
//}
RCT_EXPORT_VIEW_PROPERTY(barTintColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(tintColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(enablesReturnKeyAutomatically, BOOL)
RCT_EXPORT_VIEW_PROPERTY(barStyle, UIBarStyle)
RCT_EXPORT_VIEW_PROPERTY(returnKeyType, UIReturnKeyType)
RCT_EXPORT_VIEW_PROPERTY(keyboardType, UIKeyboardType)
RCT_EXPORT_VIEW_PROPERTY(keyboardAppearance, UIKeyboardAppearance)
RCT_REMAP_VIEW_PROPERTY(autoCapitalize, autocapitalizationType, UITextAutocapitalizationType)
RCT_REMAP_VIEW_PROPERTY(autoCorrect, autocorrectionType, UITextAutocorrectionType)
RCT_REMAP_VIEW_PROPERTY(spellCheck, spellCheckingType, UITextSpellCheckingType)
RCT_EXPORT_VIEW_PROPERTY(searchBarStyle, UISearchBarStyle)
//RCT_CUSTOM_VIEW_PROPERTY(hideBackground, BOOL, JBSearchBar)
//{
//  if ([RCTConvert BOOL:json]) {
//    view.backgroundImage = [[UIImage alloc] init];
//    view.backgroundColor = [UIColor clearColor];
//  }
//}

RCT_EXPORT_VIEW_PROPERTY(onButtonPress, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onTextChange, RCTDirectEventBlock)
//RCT_EXTERN_METHOD(
//                  setTextValueFromManager:(nonnull NSNumber *)node
//                  value:(NSString *)value
//                  )

/* Called by JS in onFocus(), onBlur(), and onCancelButtonPress() */
RCT_EXTERN_METHOD(
                  toggleCancelButton
                  :(nonnull NSNumber *)reactTag
                  flag:(BOOL)flag
                  )
/* Called by JS in the same-named class functions. */
RCT_EXTERN_METHOD(blur:(nonnull NSNumber *)reactTag)
RCT_EXTERN_METHOD(focus:(nonnull NSNumber *)reactTag)
RCT_EXTERN_METHOD(unFocus:(nonnull NSNumber *)reactTag)
RCT_EXTERN_METHOD(clearText:(nonnull NSNumber *)reactTag)

@end
