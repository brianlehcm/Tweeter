//
//  MainViewController.swift
//  Tweeter
//
//  Created by brianle on 11/22/18.
//  Copyright © 2018 brianle. All rights reserved.
//

import UIKit

let cellReuseIdentifier = "TweetTableViewCell"
let minInputViewHeight = CGFloat(100.0)
let maxInputViewHeight = CGFloat(160.0)
let marginInputViewHeight = CGFloat(36.0)
let maxLenTweet = 50

class MainViewController: UIViewController {
  @IBOutlet weak var listTweetTableView: UITableView!
  var tweets:[TweModel] = []
  var tweetInputView = TweetInputView.initFromNib() as! TweetInputView
  var grayOverlay = UIView.createGrayOverlay()
  var keyboardHeight = CGFloat(0.0)
  var currentTweetText = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  func setupUI() {
    observeKeyboardNotification()
    
    let xib = UINib(nibName: cellReuseIdentifier, bundle: nil)
    listTweetTableView.register(xib, forCellReuseIdentifier: cellReuseIdentifier)
    listTweetTableView.tableFooterView = UIView()
    
    tweetInputView.isHidden = true
    tweetInputView.frame = CGRect(x: 0.0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: minInputViewHeight)
    tweetInputView.messageTxt.delegate = self
    tweetInputView.tweetButton.addTarget(self, action: #selector(self.tweetPressed(_:)), for: .touchUpInside)
    self.view.addSubview(tweetInputView)
    
    
    NotificationCenter.default.addObserver(self, selector: #selector(self.hideInputView), name: UIApplication.willChangeStatusBarOrientationNotification, object: nil)
  }
  
  func appendTweetsData(data: [TweModel]) {
    tweets.append(contentsOf: data)
    listTweetTableView.reloadData()
  }
}

//MARK: - Handle buttons pressed
extension MainViewController {
  @objc func removeGrayView() {
    grayOverlay.removeFromSuperview()
    tweetInputView.messageTxt.resignFirstResponder()
  }
  
  @IBAction func addNewTweetPressed(_ sender: UIButton) {
    grayOverlay = UIView.createGrayOverlay()
    grayOverlay.isUserInteractionEnabled = true
    grayOverlay.addTarget(self, action: #selector(removeGrayView), for: .touchUpInside)
    self.view.addSubview(grayOverlay)
    
    resetInputView()
    
    tweetInputView.isHidden = false
    self.tweetInputView.messageTxt.becomeFirstResponder()
    
  }
  
  func resetInputView() {
    currentTweetText = ""
    tweetInputView.isHidden = true
    tweetInputView.messageTxt.text = ""
    tweetInputView.countCharsLabel.text = "Count Characters: 0"
    tweetInputView.countCharsLabel.isHidden = false
    tweetInputView.errorLabel.isHidden = true
    self.tweetInputView.frame = CGRect(x: 0.0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: minInputViewHeight)
    self.view.bringSubviewToFront(self.tweetInputView)
  }
  
  @IBAction func tweetPressed(_ sender: UIButton) {
    let strTweet = tweetInputView.messageTxt.text!
    let (checkMax, strErrorMax) = strTweet.checkNonWhiteSpaceCharacterMax(len: maxLenTweet)
    if checkMax {
      //Error input string > maxLenTweet characters
      tweetInputView.errorLabel.text = "String contain span of nonwhite space character > \(maxLenTweet)"
      tweetInputView.errorLabel.isHidden = false
      tweetInputView.countCharsLabel.isHidden = true
      
      if strErrorMax != "" {
        //Draw red background color at error string
        currentTweetText = strTweet
        let att = generateAttributedString(with: strErrorMax, targetString: strTweet)
        tweetInputView.messageTxt.attributedText = att
      }
    }
    else {
      resetInputView()
      view.endEditing(true)
      
      if strTweet.count <= 50 { //Only 1 tweet
        let model = TweModel(fromMessage: strTweet)
        //Reload data to tableview
        appendTweetsData(data: [model])
      }
      else {
        //Parse string to count how many sub tweet
        var arrTweets = strTweet.split(by: maxLenTweet)
        
        //Parse string second times to can insert "1/2 ", "2/2 " prefix sub tweets
        let strCount = "\(arrTweets.count)"
        arrTweets = strTweet.split(by: maxLenTweet - strCount.count)
        
        //Insert prefix sub tweets
        let count = arrTweets.count
        for i in 0..<arrTweets.count {
          arrTweets[i] = "\(i + 1)/\(count) \(arrTweets[i])"
        }
        
        //Prepare data sub tweets
        var tweetsData:[TweModel] = []
        for i in 0..<arrTweets.count {
          let model = TweModel(fromMessage: arrTweets[i])
          tweetsData.append(model)
        }
        
        //Reload data to tableview
        appendTweetsData(data: tweetsData)
      }
    }
  }
}

//MARK: - Handle keyboard
extension MainViewController {
  @objc func keyboardShown(_ notification: Notification) {
    keyboardHeight = ((notification.userInfo! as NSDictionary).object(forKey: UIResponder.keyboardFrameEndUserInfoKey) as AnyObject).cgRectValue.size.height
    let posY = self.view.frame.size.height - keyboardHeight - tweetInputView.frame.size.height
    tweetInputView.frame = CGRect(x: 0.0, y: posY, width: self.view.frame.size.width, height: tweetInputView.frame.size.height)
  }
  
  @objc func keyboardHidden() {
    hideInputView()
  }
  
  @objc func hideInputView() {
    view.endEditing(true)
    grayOverlay.removeFromSuperview()
    tweetInputView.isHidden = true
    tweetInputView.frame = CGRect(x: 0.0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: tweetInputView.frame.size.height)
  }
  
  func observeKeyboardNotification() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.keyboardShown(_:)),
                                           name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.keyboardHidden),
                                           name: UIResponder.keyboardWillHideNotification, object: nil)
  }
}

//MARK: - make backgroud color for error string
extension MainViewController {
  func generateAttributedString(with searchTerm: String, targetString: String) -> NSAttributedString? {
    
    let attributedString = NSMutableAttributedString(string: targetString)
    attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14.0), range: NSMakeRange(0, targetString.count))
    do {
      let regex = try NSRegularExpression(pattern: searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).folding(options: .diacriticInsensitive, locale: .current), options: .caseInsensitive)
      let range = NSRange(location: 0, length: targetString.utf16.count)
      for match in regex.matches(in: targetString.folding(options: .diacriticInsensitive, locale: .current), options: .withTransparentBounds, range: range) {
        attributedString.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.red, range: match.range)
      }
      return attributedString
    } catch {
      NSLog("Error creating regular expresion: \(error)")
      return nil
    }
  }
}

//MARK: - UITextViewDelegate
extension MainViewController: UITextViewDelegate {
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    return true
  }
  
  func textViewDidChange(_ textView: UITextView) {
    tweetInputView.errorLabel.isHidden = true
    tweetInputView.countCharsLabel.isHidden = false
    tweetInputView.countCharsLabel.text = "Count Characters: \(textView.text.count)"
    adjustTextViewHeight()
    
    if currentTweetText != "" {
      //Reset current text if have error
      tweetInputView.messageTxt.attributedText = NSMutableAttributedString(string: "")
      tweetInputView.messageTxt.text = currentTweetText
      tweetInputView.messageTxt.font = UIFont.systemFont(ofSize: 14.0)
      currentTweetText = ""
    }
  }
  
  func adjustTextViewHeight() {
    //Calculate height input text
    let fixedWidth = tweetInputView.messageTxt.frame.size.width
    let newSize = tweetInputView.messageTxt.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
    var height = newSize.height + marginInputViewHeight
    height = height < minInputViewHeight ? minInputViewHeight : (height > maxInputViewHeight ? maxInputViewHeight : height)
    
    let posY = self.view.frame.size.height - keyboardHeight - height
    tweetInputView.frame = CGRect(x: 0.0, y: posY, width: self.view.frame.size.width, height: height)
  }
}

//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! TweetTableViewCell
    let data = tweets[indexPath.row]
    cell.updateDataCel(data: data)
    return cell
  }
}

//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
  }
}
