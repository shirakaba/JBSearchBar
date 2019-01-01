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
  
  @objc var text: NSString {
    get {
      return (searchBar.text ?? "") as NSString
    }
    set {
      searchBar.text = text as String
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
