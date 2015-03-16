//
//  Spring.swift
//  HardThing
//
//  Created by Sam Noyes on 3/9/15.
//  Copyright (c) 2015 Sam Noyes. All rights reserved.
//

import Foundation
import UIKit

class Spring: Surface, ChangeableAngle {
    
    init(f:Bool, points:(Vector,Vector)) {
        super.init(fixed: f, points: points)
        angle = 0
        self.points = points
        bounceCoefficient = 1.5
    }
    override func updatePoints() {
        
    }
    override func getBP() -> UIBezierPath {
        var bp = super.getBP()
        for var i:Double = 0; i<5; i++ {
            let toAddX:Double = sin(angle)*(-(RECT_HEIGHT/2)+(RECT_HEIGHT*(i/5)))
            let toAddY:Double = cos(angle)*(-(RECT_HEIGHT/2)+(RECT_HEIGHT*(i/5)))
            let initialPoint:CGPoint = CGPointMake(CGFloat(points.0.x+toAddX),CGFloat(points.0.y+toAddY))
//            println("x: \(initialPoint.x)")
//            println("y: \(initialPoint.y)")
            bp.moveToPoint(initialPoint)
            bp.addLineToPoint(CGPointMake(CGFloat(Double(initialPoint.x) + getSurfaceVector().x), CGFloat(Double(initialPoint.y) + getSurfaceVector().y)))
        }
        return bp
    }
}