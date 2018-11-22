//
//  UITextField+Extension.swift
//  Tweeter
//
//  Created by Brian Le on 11/22/18.
//

import UIKit
import Foundation

private var __maxLengths = [UITextField: Int]()

extension UITextField {
  @IBInspectable var maxLength: Int {
    get {
      guard let l = __maxLengths[self] else {
        return 255 // (global default-limit. or just, Int.max)
      }
      return l
    }
    set {
      __maxLengths[self] = newValue
      addTarget(self, action: #selector(fix), for: .editingChanged)
    }
  }
  @objc func fix(textField: UITextField) {
    let t = textField.text
    textField.text = t?.safelyLimitedTo(length: maxLength)
  }
  
}
