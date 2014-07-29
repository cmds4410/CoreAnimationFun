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

class CACircleView: UIView {
    
    private var numLabel:UILabel?
    private var count = 0
    private var timer: NSTimer?
    private let layerBuffer:CGFloat = 40
    var animationDelegate:CACircleViewDelegate?

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
        
        let duration = 1.0
        
        let drawAnimation = CABasicAnimation()
        drawAnimation.delegate = self
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

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
