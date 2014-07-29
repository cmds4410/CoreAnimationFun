//
//  CoreAnimationDemo_Tests.swift
//  CoreAnimationDemo Tests
//
//  Created by Connor Smith on 7/28/14.
//  Copyright (c) 2014 Connor Smith. All rights reserved.
//

import UIKit
import XCTest

class CoreAnimationDemo_Tests: XCTestCase, CACircleViewDelegate {
    
    let testVC = UIViewController()
    var animationExpectation:XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testAnimationCompletion() {
        let testView = CACircleView()
        testView.animationDelegate = self
        self.testVC.viewWillAppear(true)
        self.testVC.view.addSubview(testView)
        testView.drawCircle()
        
        self.animationExpectation = self.expectationWithDescription("finished animation")
        
        self.waitForExpectationsWithTimeout(testView.animationDuration, handler: nil)
    }
    
    // MARK: CACircleViewDelegate
    
    func finishedAnimating(succeeded: Bool) {
        self.animationExpectation?.fulfill()
        println("yay!")
    }
    
}
