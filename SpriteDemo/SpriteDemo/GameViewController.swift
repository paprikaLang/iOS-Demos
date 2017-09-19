//
//  GameViewController.swift
//  SpriteDemo
//
//  Created by paprika on 2017/9/20.
//  Copyright © 2017年 paprika. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let skview = self.view as?SKView else {
            return
        }
    
        skview.backgroundColor = UIColor.white
        skview.ignoresSiblingOrder = true
        skview.showsFPS = true
        skview.showsNodeCount = true
        skview.showsPhysics = true
        //创建好SKScene和SKShapeNode之后添加一下代码
        let scene = MusiumScene(size: skview.bounds.size)
        //呈现scene,此时MusiumScene就是root node
        //此时重写didmove(to)方法,此方法在调用present时会被调用
        skview.presentScene(scene)
    }
  
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }


    override var prefersStatusBarHidden: Bool {
        return true
    }
}
