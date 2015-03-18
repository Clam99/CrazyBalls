//
//  Ball.swift
//  HardThing
//
//  Created by Sam Noyes on 3/7/15.
//  Copyright (c) 2015 Sam Noyes. All rights reserved.
//

import Foundation
import UIKit

class Ball {
    let c:Double = 0.05
    var x: Double = 0
    var y:Double = 0
    let r:Double = 0
    var vx:Double = 10
    var vy:Double = 0
    let a:Double = 0


    func updateVelocity() {//Updates Ball's velocity based on acceleration. Called before updatePos each tick.
        vy += a;
    }

    func updatePos() {//Updates Ball's position based on velocity. Called after updateVelocity each tick.
        x+=vx;
        if (vy>0) {
            y+=(vy)-(a/2);
        }
        else if (vy<0) {
            y+=(vy)-(a/2);
        }
        
    }

    init(x:Double, y:Double, radius:Double) {
        self.x = x
        self.y = y
        r = radius
        vx = (10.0*c)
        vy = 0
        a = 9.8*c
    }
    
    init(x:Double, y:Double, radius:Double, radiansCounterClockwiseFromHorizontal:Double, initialVelocity:Double) {
        self.x = x
        self.y = y
        r = radius
        vx = cos(radiansCounterClockwiseFromHorizontal)*initialVelocity
        vy = -1 * sin(radiansCounterClockwiseFromHorizontal)*initialVelocity
    }
    
    func getVelocityAsVector() -> Vector {
        return Vector(x: vx, y: vy)
    }
    func setVelocityToVector(v:Vector) {
        vx = v.x
        vy = v.y
    }
}