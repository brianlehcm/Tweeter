//
//  TweBaseModel.swift
//  Tweeter
//
//  Created by brianle on 11/22/18.
//  Copyright © 2018 brianle. All rights reserved.
//

import UIKit

class TweBaseModel {
  var tweId = -1
  
  init() {
    self.tweId = Int(Date().timeIntervalSince1970)
  }
}
