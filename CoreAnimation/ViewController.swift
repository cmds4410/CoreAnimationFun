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
    var numLabel:UILabel?
    var count = 0
    var timer: NSTimer?
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawCircle()
        self.drawNumbers()
    }

    func drawCircle() {
        let radius:CGFloat = 100.0
        let circle = CAShapeLayer()
        let centerPoint:CGPoint = CGPoint(x: CGRectGetMidX(self.view.bounds), y: CGRectGetMidY(self.view.bounds))
        let startAngle:CGFloat = CGFloat(M_PI * 3/4)
        let endAngle:CGFloat = CGFloat(M_PI * 1/4)
        
        let partialCircle = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).CGPath
        circle.path = partialCircle
        circle.strokeColor = UIColor.greenColor().CGColor
        circle.fillColor = UIColor.clearColor().CGColor
        circle.lineWidth = 30
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

    func drawNumbers() {
        let labelSize:CGFloat = 70
        let centerPoint:CGPoint = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))
        self.numLabel = UILabel(frame: CGRectMake(centerPoint.x - labelSize/2, centerPoint.y - labelSize/2, labelSize, labelSize))
        let label = self.numLabel!
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(40)
        self.view.addSubview(numLabel)
        
        label.text = "0"
        
        let maxVal = 100
        let duration:Double = 1.0 / Double(maxVal)
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(duration, target: self, selector: Selector("incrementLabel"), userInfo: nil, repeats: true)
        
        self.timer!.fire()
        
    }
    
    func incrementLabel() {
        if ( self.count >= 100 ) {
            if ( self.timer ) {
                self.timer!.invalidate()
                self.timer = nil
            }
        }
        else {
            self.count++
            self.numLabel!.text = "\(count)"
        }
    }

}

