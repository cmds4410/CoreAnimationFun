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
        
        layer.position = CGPointMake(self.view.bounds.width/2, self.view.bounds.height/2)
        layer.bounds = CGRectMake(0, 0, 50, 60)
        layer.backgroundColor = UIColor.redColor().CGColor
        self.view.layer.addSublayer(layer)
    }

    override func viewWillAppear(animated: Bool) {
        let animation = CABasicAnimation()
        animation.fromValue = NSValue(CGPoint: CGPointMake(100, 100))
        animation.toValue = NSValue(CGPoint: CGPointMake(200, 300))
        layer.position = CGPointMake(200, 300)
        layer.addAnimation(animation, forKey: "position")
    }

}

