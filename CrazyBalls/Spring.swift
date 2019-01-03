//
//  Spring.swift
//  HardThing
//
//  Created by Sam Noyes on 3/9/15.
//  Copyright (c) 2015 Sam Noyes. All rights reserved.
//

import Foundation
import UIKit

class Spring: Surface {
    let NUM_SPRING_LINES:Int = 5
    
    init(f:Bool, points:(Vector,Vector), required:Bool) {
        super.init(fixed: f, points: points, required: required)
        self.points = points
        bounceCoefficient = Double(UIScreen.main.bounds.width)/64.0
    }
    override func updatePoints() {
        
    }
    override func getBP() -> UIBezierPath {
        let bp = super.getBP()
        for i:Int in 1 ..< NUM_SPRING_LINES {
            let toAddX:Double = -sin(angle)*(-(RECT_HEIGHT/2)+(RECT_HEIGHT*(Double(i)/5)))
            let toAddY:Double = cos(angle)*(-(RECT_HEIGHT/2)+(RECT_HEIGHT*(Double(i)/5)))
            //println("toAddX = \(toAddX)")
            //println("toAddY = \(toAddY)")
            var v:Vector = getSurfaceVector()
            if (v.x < 0 && v.y < 0) {
                v = Vector.multiply(-1, v: v)
            }
            let initialPoint:CGPoint = CGPoint(x: CGFloat(points.0.x+toAddX),y: CGFloat(points.0.y+toAddY))
            //println("cx in Spring: \(initialPoint.x+CGFloat(v.x/2))")
            //println("cy in Spring: \(initialPoint.y+CGFloat(v.y/2))")
            bp.move(to: initialPoint)
            bp.addLine(to: CGPoint(x: CGFloat(Double(initialPoint.x) + v.x), y: CGFloat(Double(initialPoint.y) + v.y)))
            //println("moving to Point: x: \(getSurfaceVector().x)")
            //println("y: \(getSurfaceVector().y)")
        }
        return bp
    }
}
