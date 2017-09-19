//
//  Extensions.swift
//  SpriteDemo
//
//  Created by paprika on 2017/9/20.
//  Copyright © 2017年 paprika. All rights reserved.
//

import Foundation
import CoreGraphics
extension CGFloat{

    static func random(_ lower :CGFloat = 0,_ upper:CGFloat = 1)->CGFloat{
    
        return CGFloat(Float(arc4random())/Float(UINT32_MAX))*(upper-lower)+lower
    
    }

}
extension CGPoint {
    
        func distance(from point:CGPoint)->CGFloat{
        
            return hypot(point.x-x, point.y-y)
        
        }
    
}
