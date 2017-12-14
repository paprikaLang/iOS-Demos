//
//  PlayViewController.swift
//  Replicator
//
//  Created by paprika on 2017/12/14.
//  Copyright © 2017年 paprika. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        animation1()

    }
    
    func animation1(){
        
        let r = CAReplicatorLayer()
        r.bounds = CGRect(x: 0.0, y: 0.0, width: 60.0, height: 60.0)
        r.position = view.center
        //r.backgroundColor = UIColor.lightGray.cgColor
        view.layer.addSublayer(r)
        let bar = CALayer()
        bar.bounds = CGRect(x: 0.0, y: 0.0, width: 11.0, height: 40.0)
        bar.position = CGPoint(x: 10.0, y: 75.0)
        bar.cornerRadius = 2.0
        bar.backgroundColor = UIColor.red.cgColor
        
        r.addSublayer(bar)
        let move = CABasicAnimation(keyPath: "position.y")
        move.toValue = bar.position.y - 35.0
        move.duration = 0.5
        move.autoreverses = true
        move.repeatCount = Float.infinity
        
        bar.add(move, forKey: nil)
        r.instanceCount = 3
        r.instanceTransform = CATransform3DMakeTranslation(20.0, 0.0, 0.0)
        r.instanceDelay = 0.33
        r.masksToBounds = true
        
    }

}
