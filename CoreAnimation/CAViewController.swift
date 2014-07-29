//
//  ViewController.swift
//  CoreAnimation
//
//  Created by Connor Smith on 7/18/14.
//  Copyright (c) 2014 Connor Smith. All rights reserved.
//

import UIKit
import QuartzCore

class CAViewController: UIViewController {
    
    @IBOutlet weak var circleView: CACircleView!
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        self.circleView.drawCircle()
        self.circleView.drawNumbers()
    }


}

