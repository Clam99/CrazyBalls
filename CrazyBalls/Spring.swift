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
    
    init(points:(Vector,Vector)) {
        super.init(fixed: true, points: points)
        angle = 0
        self.points = (Vector(x:0,y:0), Vector(x:0,y:0))
        bounceCoefficient = 1.5
    }
    override func updatePoints() {
        
    }
    override func getBP() -> UIBezierPath {
        var bp = super.getBP()
        for var i = 0; i<5; i++ {
            let toAddX = sin(angle)*((RECT_HEIGHT/2)+(RECT_HEIGHT*(i/5)))
            bp.moveToPoint(CGPointMake(CGFloat(points.0.x-sin(angle)*((RECT_HEIGHT/2)+(RECT_HEIGHT*(i/5)))),CGFloat(points.0.y-cos(angle)*((RECT_HEIGHT/2)+(RECT_HEIGHT*(i/5))))))
        }
        return bp
    }
}