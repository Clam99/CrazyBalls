//
//  Spring.swift
//  HardThing
//
//  Created by Sam Noyes on 3/9/15.
//  Copyright (c) 2015 Sam Noyes. All rights reserved.
//

import Foundation

class Spring: Surface, ChangeableAngle {
    
    init(points:(Vector,Vector)) {
        super.init(fixed: true, points: points)
        angle = 0
        self.points = (Vector(x:0,y:0), Vector(x:0,y:0))
        bounceCoefficient = 1.5
    }
    override func updatePoints() {
        
    }
}