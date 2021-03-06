//
//  JBSearchBar.swift
//  
//
//  Created by jamie on 31/12/2018.
//

import Foundation

// https://teabreak.e-spres-oh.com/swift-in-react-native-the-ultimate-guide-part-2-ui-components-907767123d9e
// @objc(JBSearchBar)
class JBSearchBar: UISearchBar, UISearchBarDelegate {
  /*
   * RCTDirectEventBlock facilitates Swift -> React communication upon native event.
   * Note to self: any RCTBubblingEventBlock/RCTDirectEventBlock property MUST be prefixed with 'on' to be triggered.
   *
   * Subscribe to this native event in React by using the onButtonPress prop, e.g.:
   * onButtonPress={(e) => console.log(e.nativeEvent.type)} // prints "cancel" or "refresh".
   */
  @objc var onButtonPress: RCTDirectEventBlock?
  @objc func sendButtonPress(_ gesture: UITapGestureRecognizer) {
    if gesture.state == .ended {
      guard onButtonPress != nil else { return }
      onButtonPress!(["type": "refresh"]) // Initially anticipating 'refresh' and 'cancel' button types.
    }
  }
  
  @objc var onSearchBarTextDidEndEditing: RCTBubblingEventBlock?
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    self.eventDispatcher.sendTextEvent(with: .blur, reactTag: self.reactTag, text: text, key: nil, eventCount: nativeEventCount)
    guard onSearchBarTextDidEndEditing != nil else { return }
    onSearchBarTextDidEndEditing!([
      "target": self.reactTag,
      "searchText": (searchBar.text ?? "") as NSString
    ])
  }
  
  private var jsShowsCancelButton: Bool = true
  
  @objc var onSearchBarTextDidBeginEditing: RCTBubblingEventBlock?
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    self.setShowsCancelButton(jsShowsCancelButton, animated: true)
    self.eventDispatcher.sendTextEvent(with: .focus, reactTag: self.reactTag, text: text, key: nil, eventCount: nativeEventCount)
    guard onSearchBarTextDidBeginEditing != nil else { return }
    onSearchBarTextDidBeginEditing!([
      "target": self.reactTag,
      "searchText": (searchBar.text ?? "") as NSString
    ])
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    nativeEventCount += 1
    self.eventDispatcher.sendTextEvent(with: .change, reactTag: self.reactTag, text: text, key: searchText, eventCount: nativeEventCount)
  }
  
  @objc var onSearchButtonPress: RCTBubblingEventBlock?
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard onSearchButtonPress != nil else { return }
    onSearchButtonPress!([
      "target": self.reactTag,
      "button": "search" as NSString,
      "searchText": (searchBar.text ?? "") as NSString
    ])
  }
  
  @objc var onCancelButtonPress: RCTBubblingEventBlock?
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    // self.text = ""
    self.resignFirstResponder()
    self.setShowsCancelButton(false, animated: true)
    guard onCancelButtonPress != nil else { return }
    self.onCancelButtonPress!([:])
  }
  
  private var nativeEventCount: Int = 0
  private var eventDispatcher: RCTEventDispatcher!
  
  init(eventDispatcher: RCTEventDispatcher) {
    super.init(frame: CGRect(x: 0, y: 0, width: 1000, height: 44))
    // self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    self.delegate = self
    self.eventDispatcher = eventDispatcher
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
