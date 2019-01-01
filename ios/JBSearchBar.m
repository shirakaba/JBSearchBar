//
//  JBSearchBar.m
//  LinguaBrowse
//
//  Created by jamie on 31/12/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridge.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTComponent.h>
// #import <React/RCTEventEmitter.h>
// #import <React/RCTEventDispatcher.h>

@class RCTEventDispatcher;

@interface RNSearchBar : UISearchBar

@property(nonatomic) BOOL _jsShowsCancelButton;
@property(nonatomic, copy) RCTBubblingEventBlock onSearchButtonPress;
@property(nonatomic, copy) RCTBubblingEventBlock onCancelButtonPress;

@end

