//
//  Vector.swift
//  HardThing
//
//  Created by Sam Noyes on 3/9/15.
//  Copyright (c) 2015 Sam Noyes. All rights reserved.
//

import Foundation

class Vector {
    var x:Double
    var y:Double
    
    init(x:Double, y:Double) {
        self.x = x
        self.y = y
    }
    
    func getMagnitude() -> Double {
        return sqrt(x*x+y*y)
    }
    
    class func subtract(v1:Vector, v2:Vector) -> Vector {
        return Vector(x: v1.x-v2.x, y: v1.y-v2.y)
    }
    class func multiply(s:Double, v:Vector) -> Vector {
        return Vector(x: s*v.x, y: s*v.y)
    }
    func unitVector() -> Vector {
        return Vector(x: x/getMagnitude(),y: y/getMagnitude())
    }
    //vec.leftNormal --> vx = vec.vy; vy = -vec.vx;
    //vec.rightNormal --> vx = -vec.vy; vy = vec.vx;
    
    func leftNormal() -> Vector {
        return Vector(x: y, y: -x)
    }
    func rightNormal() -> Vector {
        return Vector(x: -y, y: x)
    }
    func projectOnto(v:Vector) -> Vector {
        return Vector.multiply(Vector.dotP(self, v2: v)/(v.getMagnitude()*v.getMagnitude()), v: v);
    }
    class func dotP(v1:Vector, v2:Vector) -> Double {
        return v1.x*v2.x+v1.y*v2.y
    }
    class func add(v1:Vector, v2:Vector) -> Vector {
        return Vector(x: v1.x+v2.x, y: v1.y+v2.y)
    }
}
