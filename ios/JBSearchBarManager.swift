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
//    guard let bridge: RCTBridge = self.bridge else {
//      return nil
//    }
//    return JBSearchBar(eventDispatcher: bridge.eventDispatcher())
    return JBSearchBar()
  }
  
  @objc func setTextValueFromManager(_ node: NSNumber, value: NSString) {
    DispatchQueue.main.async {
      let component: JBSearchBar = self.bridge.uiManager.view(forReactTag: node) as! JBSearchBar
      component.setTextValue(value)
    }
  }
}
