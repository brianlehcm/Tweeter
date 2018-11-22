//
//  NSDate+Extensions.swift
//  Tweeter
//
//  Created by Brian Le on 11/22/18.
//

import Foundation
import UIKit

internal extension DateComponents {
  mutating func to12am() {
    self.hour = 0
    self.minute = 0
    self.second = 0
  }
  mutating func to12pm() {
    self.hour = 23
    self.minute = 59
    self.second = 59
  }
}

enum CompareDateResult {
  case none
  case greater
  case smaller
  case equal
  case sameOnlyDate
}

extension Date {
  
  var tomorrow: Date {
    return Calendar.current.date(byAdding: .day, value: 1, to: self)!
  }
  
  var startOfDay: Date {
    return Calendar.current.startOfDay(for: self)
  }
  
  var endOfDay: Date? {
    var components = DateComponents()
    components.day = 1
    components.second = -1
    return (Calendar.current as NSCalendar).date(byAdding: components, to: startOfDay, options: NSCalendar.Options())
  }
  
  static func firstDateOfYear() -> Date? {
    return (Calendar.current as NSCalendar).date(era: 1, year: (Calendar.current as NSCalendar).component(.year, from: Date()), month: 1, day: 1, hour: 0, minute: 0, second: 0, nanosecond: 0)
  }
  
  func startOfWeek(_ weekday: Int?) -> Date? {
    var cal = Calendar.current
    var component = cal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
    component.to12am()
    cal.firstWeekday = weekday ?? 1
    return cal.date(from: component)!
  }
  
  func endOfWeek(_ weekday: Int) -> Date? {
    let cal: Calendar = Calendar.current
    let comp: DateComponents = (cal as NSCalendar).components([.day], from: self)
    (comp as NSDateComponents).setValue(6, forComponent: NSCalendar.Unit.day)
    return (cal as NSCalendar).date(byAdding: comp, to: self.startOfWeek(weekday)!, options: [])!
  }
  
  func startOfMonth() -> Date? {
    let cal: Calendar = Calendar.current
    var comp: DateComponents = (cal as NSCalendar).components([.year, .month], from: self)
    comp.to12pm()
    return cal.date(from: comp)!
  }
  
  func endOfMonth() -> Date? {
    let cal: Calendar = Calendar.current
    var comp: DateComponents = DateComponents()
    comp.month = 1
    comp.day = -1
    return (cal as NSCalendar).date(byAdding: comp, to: self.startOfMonth()!, options: [])!
  }
  
  func compareTwoDate(_ dateToCompare: Date) -> CompareDateResult {
    if Calendar.current.isDate(dateToCompare, inSameDayAs: self) {
      return .sameOnlyDate
    }
    switch self.compare(dateToCompare) {
    case .orderedDescending:
      return .greater
    case .orderedAscending:
      return .smaller
    case .orderedSame:
      return .equal
    }
  }
  
  func formatDateStringWithFormat(_ formatString: String) -> String {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(identifier: "UTC")
    formatter.dateFormat = formatString
    return formatter.string(from: self)
  }
  
}
