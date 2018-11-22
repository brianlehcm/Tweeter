//
//  TweetTableViewCell.swift
//  Tweeter
//
//  Created by brianle on 11/22/18.
//  Copyright © 2018 brianle. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var countCharsLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  func updateDataCel(data: TweModel) {
    messageLabel.text = data.message
    countCharsLabel.text = "Count Characters: \(data.message.count)"
    dateLabel.text = data.timeDisplay
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
