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
        let centerPoint:CGPoint = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))
        let partialCircle = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: M_PI * 3/4, endAngle: M_PI * 1/4, clockwise: true).CGPath
        circle.path = partialCircle
        circle.strokeColor = UIColor.greenColor().CGColor
        circle.fillColor = UIColor.clearColor().CGColor
        circle.lineWidth = 20
        self.view.layer.addSublayer(circle)

        let duration = 1.0
        
        let drawAnimation = CABasicAnimation()
        drawAnimation.duration = duration
        drawAnimation.fromValue = 0
        drawAnimation.toValue = duration
        circle.addAnimation(drawAnimation, forKey: "strokeEnd")

        let growAnimation = CABasicAnimation()
        growAnimation.duration = duration
        growAnimation.fromValue = 0
        growAnimation.toValue = circle.lineWidth
        circle.addAnimation(growAnimation, forKey: "lineWidth")
        
        let colorAnimation = CABasicAnimation()
        colorAnimation.duration = duration
        colorAnimation.fromValue = UIColor.blackColor().CGColor
        colorAnimation.toValue = circle.strokeColor
        circle.addAnimation(colorAnimation, forKey: "strokeColor")
        
        let animations = CAAnimationGroup()
        animations.animations = [drawAnimation, growAnimation, colorAnimation]
        circle.addAnimation(animations, forKey: nil)
    }

}

