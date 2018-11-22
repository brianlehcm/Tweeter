//
//  TweModel.swift
//  Tweeter
//
//  Created by brianle on 11/22/18.
//  Copyright © 2018 brianle. All rights reserved.
//

import UIKit

class TweModel: TweBaseModel {
  var message = String()
  var time = Date()
  var timeDisplay = String()
  init(fromMessage: String) {
    self.message = fromMessage
    self.timeDisplay = self.time.formatDateStringWithFormat("MM/dd/yy HH:mm")
    super.init()
  }
}
