//
//  UIView+Extension.swift
///  Tweeter
//
//  Created by Brian Le on 11/22/18.
//

import UIKit

extension UIView {
  class func initFromNib() -> UIView {
    let mainBundle = Bundle.main
    let className  = NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    if ( mainBundle.path(forResource: className, ofType: "nib") != nil ) {
      let objects = mainBundle.loadNibNamed(className, owner: self, options: [:])
      for object in objects! {
        if let view = object as? UIView {
          return view
        }
      }
    }
    return UIView(frame: CGRect.zero)
  }
  
  class func createGrayOverlay(_ opacity: CGFloat = 0.3) -> UIButton {
    let screenSize = UIScreen.main.bounds
    let overlay = UIButton(frame: CGRect(x: 0.9, y: 0, width: screenSize.width, height: screenSize.height))
    overlay.autoresizingMask = [.flexibleHeight, .flexibleTopMargin, .flexibleBottomMargin]
    overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    return overlay
  }
}
