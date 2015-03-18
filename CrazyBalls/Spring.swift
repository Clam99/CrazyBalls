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
    let NUM_SPRING_LINES:Int = 5
    
    init(f:Bool, points:(Vector,Vector)) {
        super.init(fixed: f, points: points)
        self.points = points
        bounceCoefficient = 5
    }
    override func updatePoints() {
        
    }
    override func getBP() -> UIBezierPath {
        var bp = super.getBP()
        for var i:Int = 1; i < NUM_SPRING_LINES; i++ {
            let toAddX:Double = -sin(angle)*(-(RECT_HEIGHT/2)+(RECT_HEIGHT*(Double(i)/5)))
            let toAddY:Double = cos(angle)*(-(RECT_HEIGHT/2)+(RECT_HEIGHT*(Double(i)/5)))
            //println("toAddX = \(toAddX)")
            //println("toAddY = \(toAddY)")
            var v:Vector = getSurfaceVector()
            if (v.x < 0 && v.y < 0) {
                v = Vector.multiply(-1, v: v)
            }
            let initialPoint:CGPoint = CGPointMake(CGFloat(points.0.x+toAddX),CGFloat(points.0.y+toAddY))
            //println("cx in Spring: \(initialPoint.x+CGFloat(v.x/2))")
            //println("cy in Spring: \(initialPoint.y+CGFloat(v.y/2))")
            bp.moveToPoint(initialPoint)
            bp.addLineToPoint(CGPointMake(CGFloat(Double(initialPoint.x) + v.x), CGFloat(Double(initialPoint.y) + v.y)))
            //println("moving to Point: x: \(getSurfaceVector().x)")
            //println("y: \(getSurfaceVector().y)")
        }
        return bp
    }
}