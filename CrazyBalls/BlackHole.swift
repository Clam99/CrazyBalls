//
//  BlackHole.swift
//  HardThing
//
//  Created by Sam Noyes on 3/9/15.
//  Copyright (c) 2015 Sam Noyes. All rights reserved.
//

import Foundation
import UIKit

class BlackHole: GameObject {
    let fixed:Bool
    var x:Double
    var y:Double
    let radius:Double = 20.0
    let strength:Double
    var done:Bool? = nil
    
    init(fixed:Bool, x:Double, y:Double, strength:Double) {
        self.fixed = fixed
        self.x = x
        self.y = y
        self.strength = strength
    }
    
    func getBP() -> UIBezierPath {
        let bp = UIBezierPath(arcCenter: CGPointMake(CGFloat(x), CGFloat(y)), radius: CGFloat(radius), startAngle: CGFloat(0), endAngle: CGFloat(7), clockwise: true)
        return bp
    }
    
}