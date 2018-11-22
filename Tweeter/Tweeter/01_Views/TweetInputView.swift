//
//  TweetInputView.swift
//  Tweeter
//
//  Created by brianle on 11/22/18.
//  Copyright © 2018 brianle. All rights reserved.
//

import UIKit

class TweetInputView: UIView {
  @IBOutlet weak var messageTxt: UITextView!
  @IBOutlet weak var countCharsLabel: UILabel!
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var tweetButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.layer.borderWidth = 1.0
    self.layer.borderColor = UIColor(rgb: 0xDCDCDC).cgColor
    
    messageTxt.layer.borderWidth = 1.0
    messageTxt.layer.borderColor = UIColor(rgb: 0xDCDCDC).cgColor
  }
}
