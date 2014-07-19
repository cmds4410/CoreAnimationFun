//
//  ViewController.swift
//  CoreAnimation
//
//  Created by Connor Smith on 7/18/14.
//  Copyright (c) 2014 Connor Smith. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    let layer = CALayer()
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawCircle()
    }

    func drawCircle() {
        let radius:CGFloat = 100
        let circle = CAShapeLayer()
        circle.path = UIBezierPath(roundedRect: CGRectMake(0.0, 0.0, 2 * radius , 2 * radius), cornerRadius: radius).CGPath
        circle.position = CGPointMake(CGRectGetMidX(self.view.bounds) - radius, CGRectGetMidY(self.view.bounds) - radius)
        circle.strokeColor = UIColor.blackColor().CGColor
        circle.fillColor = UIColor.clearColor().CGColor
        circle.lineWidth = 5
        self.view.layer.addSublayer(circle)
        
        let drawAnimation = CABasicAnimation()
        drawAnimation.duration = 1
        drawAnimation.repeatCount = 1
        drawAnimation.fromValue = 0
        drawAnimation.toValue = 1
        circle.addAnimation(drawAnimation, forKey: "strokeEnd")
    }

}

