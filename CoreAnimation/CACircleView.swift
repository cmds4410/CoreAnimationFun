//
//  AnimationView.swift
//  CoreAnimation
//
//  Created by Connor Smith on 7/28/14.
//  Copyright (c) 2014 Connor Smith. All rights reserved.
//

import UIKit
import QuartzCore

protocol CACircleViewDelegate {
    func finishedAnimating(succeeded: Bool) -> ()
}

class CADynamicHub:NSObject,UIDynamicItem {
    var center:CGPoint
    var bounds: CGRect
    var transform: CGAffineTransform
    init(center: CGPoint, bounds: CGRect, transform: CGAffineTransform) {
        self.center = center
        self.bounds = bounds
        self.transform = transform
    }
}

class CACircleView: UIView {
    
    private var numLabel:UILabel?
    private var count = 0
    private var timer: NSTimer?
    private let layerBuffer:CGFloat = 40
    
    var animationDelegate:CACircleViewDelegate?
    let animationDuration = 1.0
    
    var dynamicAnimator:UIDynamicAnimator?

    init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }
    
    func drawCircle() {
        let radius:CGFloat = (CGRectGetWidth(self.bounds) / 2) - layerBuffer
        let circle = CAShapeLayer()
        let centerPoint:CGPoint = CGPoint(x: CGRectGetMidX(self.bounds), y: CGRectGetMidY(self.bounds))
        let startAngle:CGFloat = CGFloat(M_PI * 3/4)
        let endAngle:CGFloat = CGFloat(M_PI * 1/4)
        
        let partialCircle = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).CGPath
        circle.path = partialCircle
        circle.strokeColor = UIColor.greenColor().CGColor
        circle.fillColor = UIColor.clearColor().CGColor
        circle.lineWidth = 30
        self.layer.addSublayer(circle)
        
        // add dynamic behavior
        
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self)
        let dynamicHub = CADynamicHub(center: CGPoint(x: -5, y: -5), bounds: self.bounds, transform: CGAffineTransformIdentity)
        
        let snap = UISnapBehavior(item: dynamicHub, snapToPoint: CGPoint(x: 1, y: 1))
        snap.damping = 2
        
        snap.action = {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            circle.strokeEnd = dynamicHub.center.x
            CATransaction.commit()
        }
        
        self.dynamicAnimator?.addBehavior(snap)
        
        let drawAnimation = CABasicAnimation()
        drawAnimation.delegate = self
        drawAnimation.duration = self.animationDuration
        drawAnimation.fromValue = 0
        drawAnimation.toValue = 1
//        circle.addAnimation(drawAnimation, forKey: "strokeEnd")
        
        let growAnimation = CABasicAnimation()
        growAnimation.duration = self.animationDuration
        growAnimation.fromValue = 0
        growAnimation.toValue = circle.lineWidth
        circle.addAnimation(growAnimation, forKey: "lineWidth")
        
        let colorAnimation = CABasicAnimation()
        colorAnimation.duration = self.animationDuration
        colorAnimation.fromValue = UIColor.blackColor().CGColor
        colorAnimation.toValue = circle.strokeColor
        circle.addAnimation(colorAnimation, forKey: "strokeColor")
        
        let animations = CAAnimationGroup()
        animations.animations = [drawAnimation, growAnimation, colorAnimation]
        circle.addAnimation(animations, forKey: nil)
    }
    
    func drawNumbers() {
        let labelSize:CGFloat = 70
        let centerPoint:CGPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
        self.numLabel = UILabel(frame: CGRectMake(centerPoint.x - labelSize/2, centerPoint.y - labelSize/2, labelSize, labelSize))
        let label = self.numLabel!
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(40)
        self.addSubview(numLabel)
        
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
    
    // MARK: CAAnimationDelegate
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        println("animation complete")
        self.animationDelegate?.finishedAnimating(flag)
    }
}
