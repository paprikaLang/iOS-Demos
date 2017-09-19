//
//  MusiumScene.swift
//  SpriteDemo
//
//  Created by paprika on 2017/9/20.
//  Copyright © 2017年 paprika. All rights reserved.
//

import UIKit
import SpriteKit

let artists = ["Adele", "Linkin Park", "Lady Gaga", "Miley Cyrus", "Bob Dylan", "Queen", "U2", "Coldplay", "Jay-Z", "Michael Jackson", "Rihanna", "David Bowie", "Katy Perry", "Amy Winehouse", "Madonna", "Justin Bieber"]
class MusiumScene: SKScene {
    
    var isMoving = false

    //在VC里被present方法调用
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        //禁止重力,否则所有设置过的phsicBody的node都会收重力影响自动坠落
        physicsWorld.gravity = CGVector.zero
        backgroundColor = UIColor.white
        let viewWidth = view.frame.size.width
        let viewHeight = view.frame.size.height
        let radius = max(viewWidth, viewHeight)
        //添加一个具有向心力的特殊SKFieldNode,在其region内的所有node都会受其影响,自动向中心移动
        let fieldNode = SKFieldNode.radialGravityField()
        fieldNode.region = SKRegion(radius: Float(radius))
        fieldNode.minimumRadius = Float(radius)
        fieldNode.strength = 50
        addChild(fieldNode)
        //修改坐标原点,SpriteKit坐标原点在左下角
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //添加所有MusiumNodes,初始随机分配在左右两侧,受向心力作用,会自动汇聚在中心点
        for (index,musiumName) in artists.enumerated() {
            let node = MusiumNode(musiumName: musiumName)
            //平均分配左右两侧.此时运行所有的nodes都会停留在屏幕两侧不向中心靠拢,因为在Node中缺一个便利构造方法
            let x = (index%2 == 0) ? -viewWidth/2 : viewWidth/2
            let y = CGFloat.random(-viewHeight/2, viewHeight/2)
   
            node.position = CGPoint(x: x, y: y)
            addChild(node)
            
        }
        
    }
}

//MARK: Move
extension MusiumScene{
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let previous = touch.previousLocation(in: self)
        let location = touch.location(in: self)
        
        if location.distance(from: previous) == 0{
            return
        }
        isMoving = true
        
        let x = location.x - previous.x
        let y = location.y - previous.y
        
        for node in children{
            let distance = node.position.distance(from: location)
            let acceleration: CGFloat = 3 * pow(distance, 1/2)
            let direction = CGVector(dx: x * acceleration, dy: y * acceleration)
            //在手指滑动的方向上施加一个作用力
            node.physicsBody?.applyForce(direction)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first, !isMoving else {
            isMoving = false
            return
        }
        //通过判断,看是点击还是滑动
        isMoving = false
        
        let location = touch.location(in: self)
        
        guard let musiumNode = musiumNodeAt(location) else{
            return
        }
        //被选择了会方法,相反会缩小
        musiumNode.isSelected = !musiumNode.isSelected
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isMoving = false
    }
    
    
    /**
     查找被点击的 MusiumNode.
     */
    func musiumNodeAt(_ p: CGPoint) -> MusiumNode? {
        var node = self.atPoint(p)
        if node === self {
            return nil
        }
        while true {
            if node is MusiumNode{
                return node as? MusiumNode
            }else if let parent = node.parent {
                node = parent
            }else{
                break
            }
        }
        
        return nil
    }
    
}
