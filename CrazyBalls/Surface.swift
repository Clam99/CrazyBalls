//
//  Surface.swift
//  HardThing
//
//  Created by Sam Noyes on 3/9/15.
//  Copyright (c) 2015 Sam Noyes. All rights reserved.
//

import Foundation

class Surface:GameObject, ChangeableAngle {
    var bounceCoefficient:Double
    
    var angle:Double
    
    var points:(Vector, Vector)
    
    var fixed:Bool
    
    init(fixed:Bool, points:(Vector, Vector)) {
        self.fixed = fixed
        self.angle = atan((points.0.y-points.1.y)/(points.0.x-points.1.x))
        self.bounceCoefficient = 1.0
        self.points = points;
    }
    
    func setAngle(val:Double) {
        angle = val
        updatePoints()
    }
    
    func setPoints(points:(Vector,Vector)) {
        self.points = points
        updatePoints()
    }
    
    func updatePoints() {
        
    }
    
    func getSurfaceVector() -> Vector {
        return Vector.subtract(points.0, v2: points.1)
    }
    
    func isTouchingBall(ball:Ball) -> Bool {
        let sToB:Vector = Vector(x: ball.x-points.0.x, y: ball.y-points.0.y);//top of surface to ball vector
        var projLength:Double = sToB.getMagnitude()*(Vector.dotP(sToB, v2: getSurfaceVector())/(sToB.getMagnitude()*getSurfaceVector().getMagnitude()));//length of projection of sToB onto the surface
        projLength = projLength*Double(-1.0)
        ////println(projLength)
        if (projLength < -ball.r || projLength>getSurfaceVector().getMagnitude()+ball.r) {//Off to the side of the ramp
            //println("Ball is off to the side")
            return false;
        }
        else if (projLength>0&&projLength<getSurfaceVector().getMagnitude()) {//must be above ramp
            let surfacePoint:Vector = getCoordsCorrespondingToXAndYWithAngle(ball.x, y: ball.y);
            ////println("surfacePt x: \(surfacePoint.x) y: \(surfacePoint.y)")
            let vectorToSurface:Vector = Vector(x: surfacePoint.x-ball.x, y: surfacePoint.y-ball.y);
            let b:Bool = vectorToSurface.getMagnitude()<ball.r
            ////println("Within reach: \(b)")
            return b
        }
        else {//Not directly above the ramp, but still might be within reach
            return (getDistance(points.1.x,y1: points.1.y,x2: ball.x, y2: ball.y)<ball.r) || (getDistance(points.0.x,y1: points.0.y,x2: ball.x, y2: ball.y))<ball.r;
        }
    }
    
    func getCoordsCorrespondingToXAndYWithAngle(x:Double, y:Double) -> Vector {
        let toProj:Vector = Vector(x: x-points.0.x,y: y-points.0.y);
        let proj:Vector = toProj.projectOnto(getSurfaceVector());
        return Vector.add(Vector(x: points.0.x, y: points.0.y), v2: proj);
    }
    
    func getDistance(x1:Double, y1:Double, x2:Double, y2:Double) -> Double {
        return sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))
    }
    
    
    
    
}