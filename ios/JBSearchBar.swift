//
//  JBSearchBar.swift
//  
//
//  Created by jamie on 31/12/2018.
//

import Foundation

// https://teabreak.e-spres-oh.com/swift-in-react-native-the-ultimate-guide-part-2-ui-components-907767123d9e
class JBSearchBar: UIView, UISearchBarDelegate {
  lazy var searchBar: UISearchBar = {
    let sb = UISearchBar()
    sb.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    return sb
  }()
  
  /* JBSearchBarManager exposes this as a view property, so this ONLY manifests as a prop.
   * Hence, no need for getter. */
  @objc var text: NSString = "" {
//    get {
//      return (searchBar.text ?? "") as NSString
//    }
    didSet {
      searchBar.text = text as String
    }
  }
  
  // The obj-c selector 'setText' is implicitly generated as 'text' is a computed property.
  @objc func setTextValue(_ value: NSString) {
    self.text = value
  }
  
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
  
  private var eventDispatcher: RCTEventDispatcher!
  private var nativeEventCount: Int = 0
  
//  init(eventDispatcher: RCTEventDispatcher) {
//    super.init(frame: CGRect(x: 0, y: 0, width: 1000, height: 44))
//    self.eventDispatcher = eventDispatcher
//    self.delegate = self
//  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(searchBar)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
