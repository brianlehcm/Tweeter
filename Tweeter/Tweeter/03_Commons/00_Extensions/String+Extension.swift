//
//  String+Extension.swift
//  Tweeter
//
//  Created by Brian Le on 11/22/18.
//

import Foundation

extension String {
  func safelyLimitedTo(length n: Int)->String {
    if (self.count <= n) {
      return self
    }
    return String( Array(self).prefix(upTo: n) )
  }
  
  func checkNonWhiteSpaceCharacterMax() -> (Bool, String) {
    let arrStrs = self.components(separatedBy: " ")
    let counts:[Int] = arrStrs.map({ $0.count })
    if let maxLen = counts.max() {
      var str = ""
      if let find = arrStrs.filter({ $0.count > 50 }).first {
        str = find
      }
      return (maxLen > 50, str)
    }
    return (false, "")
  }
  
  func split(by length: Int) -> [String] {
    let arrStrs = self.components(separatedBy: " ")
    var results:[String] = []
    
    var temp = ""
    var add = 0
    for str in arrStrs {
      add = temp == "" ? 1 : 0
      let countStr = "\(results.count + 1). "
      if temp.count + str.count + add + countStr.count < length {
        temp = temp == "" ? temp.appending(str) : temp.appending(" \(str)")
        if str == arrStrs.last{
          results.append(temp)
        }
      }
      else {
        results.append(temp)
        temp = str
        if str == arrStrs.last{
          results.append(temp)
        }
      }
    }
    
    return results
  }
}
