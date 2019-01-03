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
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    self.eventDispatcher.sendTextEvent(with: .blur, reactTag: self.reactTag, text: text, key: nil, eventCount: nativeEventCount)
  }
  
  private var jsShowsCancelButton: Bool = true
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    self.setShowsCancelButton(jsShowsCancelButton, animated: true)
    self.eventDispatcher.sendTextEvent(with: .focus, reactTag: self.reactTag, text: text, key: nil, eventCount: nativeEventCount)
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
    self.text = ""
    self.resignFirstResponder()
    self.setShowsCancelButton(false, animated: true)
    guard onCancelButtonPress != nil else { return }
    self.onCancelButtonPress!([:])
  }
  
  private var nativeEventCount: Int = 0
  private var eventDispatcher: RCTEventDispatcher!
  private var refreshButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
  
  init(eventDispatcher: RCTEventDispatcher) {
    super.init(frame: CGRect(x: 0, y: 0, width: 1000, height: 44))
    // self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    self.delegate = self
    self.eventDispatcher = eventDispatcher
   
    
    let btnImage = UIImage(named: "refresh_dummy3")
    refreshButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
    refreshButton.setImage(btnImage, for: UIControl.State.normal)
    
//    guard let buttonContainer: UIView = self.subviews.first(where: {
//      (subview) in
//        return subview.subviews.first(where: { (subsubview) in subsubview as? UIButton != nil }) != nil
//    }) else { return }
    
    // guard let textField = self.subviews.first(where: { $0 as? UITextField != nil }) else { return }
    self.addSubview(refreshButton)
    self.bringSubviewToFront(refreshButton)
    
    // refreshButton.leadingAnchor.constraint(equalTo: wv.leadingAnchor).isActive = true
    refreshButton.translatesAutoresizingMaskIntoConstraints = false
    refreshButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
    refreshButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    refreshButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    refreshButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
