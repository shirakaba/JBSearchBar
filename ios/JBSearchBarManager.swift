//
//  JBSearchBarManager.swift
//  LinguaBrowse
//
//  Created by jamie on 31/12/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation

// https://medium.com/@jpdriver/vending-pure-swift-views-in-react-native-3f417349e3c6
// https://teabreak.e-spres-oh.com/swift-in-react-native-the-ultimate-guide-part-2-ui-components-907767123d9e
@objc(JBSearchBarManager)
class JBSearchBarManager: RCTViewManager {
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  override func view() -> UIView! {
    // return JBSearchBar(eventDispatcher: <#T##RCTEventDispatcher#>)
    return JBSearchBar()
  }
}
