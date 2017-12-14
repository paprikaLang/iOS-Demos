//
//  LoadViewController.swift
//  Replicator
//
//  Created by paprika on 2017/12/14.
//  Copyright © 2017年 paprika. All rights reserved.
//

import UIKit

class LoadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        animation2()

    }

    func animation2()  {
        
        let r = CAReplicatorLayer()
        r.bounds = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0)
        r.cornerRadius = 10.0
        r.backgroundColor = UIColor(white: 0.0, alpha: 0.75).cgColor
        r.position = view.center
        
        view.layer.addSublayer(r)
        
        let dot = CALayer()
        dot.bounds = CGRect(x: 0.0, y: 0.0, width: 14.0, height: 14.0)
        dot.position = CGPoint(x: 100.0, y: 40.0)
        dot.backgroundColor = UIColor(white: 0.8, alpha: 1.0).cgColor
        dot.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        dot.borderWidth = 1.0
        dot.cornerRadius = 2.0
        
        r.addSublayer(dot)
        
        let nrDots: Int = 15
        
        r.instanceCount = nrDots
        let angle = CGFloat(2*Double.pi) / CGFloat(nrDots)
        r.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
        
        let duration: CFTimeInterval = 1.5
        
        let shrink = CABasicAnimation(keyPath: "transform.scale")
        shrink.fromValue = 1.0
        shrink.toValue = 0.1
        shrink.duration = duration
        shrink.repeatCount = Float.infinity
        
        dot.add(shrink, forKey: nil)
        
        r.instanceDelay = duration/Double(nrDots)
        
        dot.transform = CATransform3DMakeScale(0.01, 0.01, 0.01)
    }
    
}
