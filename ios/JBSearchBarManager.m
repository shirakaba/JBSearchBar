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

// https://teabreak.e-spres-oh.com/swift-in-react-native-the-ultimate-guide-part-2-ui-components-907767123d9e
// "If the exposed name ends with Manager, React Native will automatically remove the Manager ending."
@interface RCT_EXTERN_MODULE(JBSearchBarManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(count, NSNumber)

@end
