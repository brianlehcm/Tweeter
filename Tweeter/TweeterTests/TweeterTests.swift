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

    func testExample() {
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
