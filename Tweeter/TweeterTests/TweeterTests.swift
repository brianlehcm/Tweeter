//
//  TweeterTests.swift
//  TweeterTests
//
//  Created by brianle on 11/22/18.
//  Copyright © 2018 brianle. All rights reserved.
//

import XCTest
@testable import Tweeter

class TweeterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
  
    func testErrorNonSpace() {
      let str1 = "ThequickbrownfoxjumpsoverthelazydogThequickbrownfoxjumpsoverthelazydog"
      let (check1, _) = str1.checkNonWhiteSpaceCharacterMax(len: 50)
      print(check1)
      XCTAssert(check1, "Case 1: String contain span of nonwhite space character > 50")
      
      let str2 = "ThequickbrownfoxjumpsoverthelazydogThequickbrownfoxjumpsoverthelazydog asdjaska sadjkl"
      let (check2, _) = str2.checkNonWhiteSpaceCharacterMax(len: 50)
      print(check2)
      XCTAssert(check2, "Case 2: String contain span of nonwhite space character > 50")
    }
  
    func testOnTweet() {
      let str = "The quick brown fox jumps over the lazy dog"
      XCTAssertTrue(str.count <= 50, "More tweets")
    }

    func testSubTweets() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
      let str = Lorem.tweet
      var arr = str.split(by: 50)
      let strCount = "\(arr.count)"
      arr = str.split(by: 50 - strCount.count)
      
      let count = arr.count
      for i in 0..<arr.count {
        arr[i] = "\(i + 1)/\(count) \(arr[i])"
      }
      
      for i in 0..<arr.count {
        print("count: \(arr[i].count), str: \(arr[i])")
        XCTAssertTrue(arr[i].count <= 50, "Split tweet wrong")
      }
      
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
