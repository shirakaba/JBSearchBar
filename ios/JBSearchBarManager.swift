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
  @objc override func constantsToExport() -> [AnyHashable : Any]! {
    return [
      "ComponentHeight": self.view()?.intrinsicContentSize.height ?? 0
    ]
  }
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  override func view() -> UIView! {
    guard let bridge: RCTBridge = self.bridge else {
      print("[JBSearchBarManager] Unable to get reference to bridge, so can't generate view!")
      return nil
    }
    return JBSearchBar(eventDispatcher: bridge.eventDispatcher())
  }
  
//  @objc func setTextValueFromManager(_ node: NSNumber, value: NSString) {
//    DispatchQueue.main.async {
//      let component: JBSearchBar = self.bridge.uiManager.view(forReactTag: node) as! JBSearchBar
//      component.setTextValue(value)
//    }
//  }
  
  /* Called by JS in the same-named class functions. */
  @objc func blur(_ reactTag: NSNumber){
    guard let bridge: RCTBridge = self.bridge, let uiManager = bridge.uiManager else {
      return print("[JBSearchBarManager] Unable to get reference to bridge/UIManager, so can't blur!")
    }
    uiManager.addUIBlock({ (uiManager, viewRegistry) in
      guard let sb: JBSearchBar = viewRegistry?[reactTag] as? JBSearchBar else {
        return print("ERROR: Cannot toggle JBSearchbar cancel button; (tag #%@) is not a JBSearchBar", reactTag)
      }
      sb.endEditing(true)
    })
  }
  
  @objc func focus(_ reactTag: NSNumber){
    guard let bridge: RCTBridge = self.bridge, let uiManager = bridge.uiManager else {
      return print("[JBSearchBarManager] Unable to get reference to bridge/UIManager, so can't focus!")
    }
    uiManager.addUIBlock({ (uiManager, viewRegistry) in
      guard let sb: JBSearchBar = viewRegistry?[reactTag] as? JBSearchBar else {
        return print("ERROR: Cannot toggle JBSearchbar cancel button; (tag #%@) is not a JBSearchBar", reactTag)
      }
      sb.becomeFirstResponder()
    })
  }
  
  @objc func unFocus(_ reactTag: NSNumber){
    guard let bridge: RCTBridge = self.bridge, let uiManager = bridge.uiManager else {
      return print("[JBSearchBarManager] Unable to get reference to bridge/UIManager, so can't unfocus!")
    }
    uiManager.addUIBlock({ (uiManager, viewRegistry) in
      guard let sb: JBSearchBar = viewRegistry?[reactTag] as? JBSearchBar else {
        return print("ERROR: Cannot toggle JBSearchbar cancel button; (tag #%@) is not a JBSearchBar", reactTag)
      }
      sb.resignFirstResponder()
    })
  }
  
  @objc func clearText(_ reactTag: NSNumber){
    guard let bridge: RCTBridge = self.bridge, let uiManager = bridge.uiManager else {
      return print("[JBSearchBarManager] Unable to get reference to bridge/UIManager, so can't clear text!")
    }
    uiManager.addUIBlock({ (uiManager, viewRegistry) in
      guard let sb: JBSearchBar = viewRegistry?[reactTag] as? JBSearchBar else {
        return print("ERROR: Cannot toggle JBSearchbar cancel button; (tag #%@) is not a JBSearchBar", reactTag)
      }
      sb.text = ""
    })
  }
  
  /* Called by JS in onFocus(), onBlur(), and onCancelButtonPress() */
  @objc func toggleCancelButton(_ reactTag: NSNumber, flag: Bool){
    guard let bridge: RCTBridge = self.bridge, let uiManager = bridge.uiManager else {
      return print("[JBSearchBarManager] Unable to get reference to bridge/UIManager, so can't toggle Cancel button!")
    }
    uiManager.addUIBlock({ (uiManager, viewRegistry) in
      guard let sb: JBSearchBar = viewRegistry?[reactTag] as? JBSearchBar else {
        return print("ERROR: Cannot toggle JBSearchbar cancel button; (tag #%@) is not a JBSearchBar", reactTag)
      }
      sb.setShowsCancelButton(flag, animated: true)
    })
  }
}
