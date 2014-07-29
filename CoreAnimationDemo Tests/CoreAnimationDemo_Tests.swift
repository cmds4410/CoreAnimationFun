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
