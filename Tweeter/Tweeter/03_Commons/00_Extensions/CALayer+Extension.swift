//
//  CALayer+Extension.swift
//  Tweeter
//
//  Created by Brian Le on 11/22/18.
//

import UIKit

extension CALayer {
  var borderUIColor: UIColor {
    set {
      self.borderColor = newValue.cgColor
    }
    get {
      return UIColor(cgColor: self.borderColor!)
    }
  }
}
