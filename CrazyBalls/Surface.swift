//
//  Surface.swift
//  HardThing
//
//  Created by Sam Noyes on 3/9/15.
//  Copyright (c) 2015 Sam Noyes. All rights reserved.
//

import Foundation
import UIKit


class Surface:GameObject, ChangeableAngle {
    var bounceCoefficient:Double
    
    var points:(Vector, Vector)
    
    var angle:Double
    
    var done:Bool? = nil
    
    var fixed:Bool
    
    let RECT_HEIGHT:Double = 10
    
    init(fixed:Bool, points:(Vector, Vector), required:Bool) {
        self.fixed = fixed
        self.points = points
        self.angle = atan((points.0.y-points.1.y)/(points.0.x-points.1.x))
        //println("the angle is \(angle*(180/M_PI)) in degrees and \(angle) in radians")
        self.bounceCoefficient = 0.0
        if required {
            done = false
        }
    }
    
    func setAngle(_ val:Double) {
        angle = val
        updatePoints()
    }
    
    
    func setPoints(_ points:(Vector,Vector)) {
        self.points = points
        updatePoints()
    }
    
    func updatePoints() {
        
    }
    
    func getSurfaceVector() -> Vector {
        let v = Vector.subtract(points.0, v2: points.1)
        return v
    }
    
    func isTouchingBall(_ ball:Ball) -> Bool {
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
    
    func getCoordsCorrespondingToXAndYWithAngle(_ x:Double, y:Double) -> Vector {
        let toProj:Vector = Vector(x: x-points.0.x,y: y-points.0.y);
        let proj:Vector = toProj.projectOnto(getSurfaceVector());
        return Vector.add(Vector(x: points.0.x, y: points.0.y), v2: proj);
    }
    
    func getDistance(_ x1:Double, y1:Double, x2:Double, y2:Double) -> Double {
        return sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))
    }
    
    func getBP() -> UIBezierPath {
        var rect:CGRect
        let length:Double = getSurfaceVector().getMagnitude()
        let cx = points.1.x+(points.0.x-points.1.x)/2
        let cy = points.1.y+(points.0.y-points.1.y)/2
        //println("cx: \(cx) and cy: \(cy)")
        let bp = UIBezierPath(roundedRect: CGRect(x: CGFloat(0-length/2),y: CGFloat(0-RECT_HEIGHT/2), width: CGFloat(length), height: CGFloat(RECT_HEIGHT)), cornerRadius: CGFloat(5))
        let a = CGFloat(Double(angle))
        let transform:CGAffineTransform = CGAffineTransform(rotationAngle: a)
        //println("Well the angle that I'm drawing is \(a) in radians using the angle \(angle) in radians")
        bp.apply(transform)
        let transform2:CGAffineTransform = CGAffineTransform(translationX: CGFloat(cx), y: CGFloat(cy))
        bp.apply(transform2)
        return bp
    }
    
    
}
