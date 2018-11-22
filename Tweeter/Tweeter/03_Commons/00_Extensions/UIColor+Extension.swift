//
//  UIColor+Extension.swift
//  Tweeter
//
//  Created by Brian Le on 11/22/18.
//

import UIKit

extension UIColor {
  var toHexString: String {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    
    self.getRed(&r, green: &g, blue: &b, alpha: &a)
    
    let str = String(
      format: "#%02X%02X%02X",
      Int(r * 0xff),
      Int(g * 0xff),
      Int(b * 0xff)
    )
    
    return str
  }
  
  public class func pieChartLegendColors() -> [UIColor] {
    return [UIColor.init(rgb: 0x29ABE2), UIColor.init(rgb: 0x3683BB), UIColor.init(rgb: 0xFE8023), UIColor.init(rgb: 0xFFFB76), UIColor.init(rgb: 0xFF0000)]
  }
  
  public class func colorE6E6E6() -> UIColor {
    return colorWith(red: 0xE6, green: 0xE6, blue: 0xE6)
  }

  public class func color055EEA() -> UIColor {
    return UIColor(rgb: 0x055EEA)
  }

  public class func color00469c() -> UIColor {
    return UIColor(rgb: 0x00469c)
  }

  public class func color055EAA() -> UIColor {
    return UIColor(rgb: 0x055EAA)
  }

  public class func color3683BB() -> UIColor {
    return UIColor(rgb: 0x3683BB)
  }

  public class func color29ABE2() -> UIColor {
    return UIColor(rgb: 0x29ABE2)
  }

  public class func colorA6A6A6() -> UIColor {
    return UIColor(rgb: 0xA6A6A6)
  }

  public class func colorFE8023() -> UIColor {
    return UIColor(rgb: 0xFE8023)
  }

  public class func colorFFFB76() -> UIColor {
    return UIColor(rgb: 0xFFFB76)
  }

  public class func colorF2F2F2() -> UIColor {
    return UIColor(rgb: 0xF2F2F2)
  }
  
  public class func colorC2C2C2() -> UIColor {
    return UIColor(rgb: 0xC2C2C2)
  }

  public class func buttonNormalColor() -> UIColor {
    return colorWith(red: 0x05, green: 0x5e, blue: 0xaa)
  }
  
  public class func buttonHighlightedColor() -> UIColor {
    return colorWith(red: 0x12, green: 0x92, blue: 0xe0)
  }

  func toARGB() -> Int {
    let maxColor = CGFloat(255.0)
    var fRed : CGFloat = 0
    var fGreen : CGFloat = 0
    var fBlue : CGFloat = 0
    var fAlpha: CGFloat = 0
    if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
      let iRed = Int(fRed * maxColor)
      let iGreen = Int(fGreen * maxColor)
      let iBlue = Int(fBlue * maxColor)
      let iAlpha = Int(fAlpha * maxColor)

      //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
      return (iAlpha << 24) + (iRed << 16) + (iGreen << 8) + iBlue
    } else {
      return 0x00000000
    }
  }

  //NguyenHuynh: this to support both 32 & 64 bit systems
  func toRGB() -> Int {
    let maxColor = CGFloat(255.0)
    var fRed : CGFloat = 0
    var fGreen : CGFloat = 0
    var fBlue : CGFloat = 0
    var fAlpha: CGFloat = 0
    if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
      let iRed = Int(fRed * maxColor)
      let iGreen = Int(fGreen * maxColor)
      let iBlue = Int(fBlue * maxColor)

      // Bits 16-23 are red, 8-15 are green, 0-7 are blue).
      return (iRed << 16) + (iGreen << 8) + iBlue
    } else {
      return 0x000000
    }
  }

  fileprivate class func colorWith(red: Int, green: Int, blue: Int, alpha: Int = 1) -> UIColor {
    return UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(alpha))
  }
  
  convenience init(rgb: Int) {
    self.init(
      red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgb & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
  
  convenience init(hex: String) {
    let scanner = Scanner(string: hex)
    scanner.scanLocation = 0
    
    var rgbValue: UInt64 = 0
    
    scanner.scanHexInt64(&rgbValue)
    
    let r = (rgbValue & 0xff0000) >> 16
    let g = (rgbValue & 0xff00) >> 8
    let b = rgbValue & 0xff
    
    self.init(
      red: CGFloat(r) / 0xff,
      green: CGFloat(g) / 0xff,
      blue: CGFloat(b) / 0xff, alpha: 1
    )
  }
}
