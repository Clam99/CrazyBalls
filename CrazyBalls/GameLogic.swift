//
//  GameLogic.swift
//  HardThing
//
//  Created by Sam Noyes on 3/9/15.
//  Copyright (c) 2015 Sam Noyes. All rights reserved.
//

import Foundation
import UIKit

class GameLogic {
    let frame:CGRect
    let radius = 25.0
    var balls:[Ball]
    var ll:LevelLayout
    
    init(frame:CGRect) {
        self.frame = frame
        balls = [Ball(x:Double(frame.size.width)/2, y: Double(frame.size.height)/2, radius: radius)]
        ll = GameLogic.gameLayoutArray()[0]
    }
    
    func updateLogic() {
        for ball in balls {
            var bouncing = false
            ball.updateVelocity()
            ball.updatePos()
            if (ball.x+ball.r > Double(frame.size.width)) {
                ball.x = (Double(frame.size.width)-ball.r) //commenting this out fixes the problem of losing energy for some reason
                ball.vx *= -1
                bouncing = true
            }
            else if (ball.x-ball.r < 0) {
                ball.x = ball.r
                ball.vx *= -1
                bouncing = true
            }
            if (ball.y+ball.r > Double(frame.size.height)) {
                ball.y = Double(frame.size.height)-ball.r
                ball.vy *= -1
                bouncing = true
            }
            else if (ball.y-ball.r < 0) {
                ball.y = ball.r
                ball.vy *= -1
                bouncing = true
            }
            let totalE:Double = (ball.vy*ball.vy*0.5)+(ball.a*(Double(frame.size.height)-ball.y))
            for obj in ll.fixedObjects {
                if let surface = obj as? Surface {
                    if surface.isTouchingBall(ball) {
                        bounce(surface,ball: ball)
                        moveBallOut(ball, s: surface)
                    }
                }
            }
        }
    }
    
    func moveBallOut(b:Ball, s:Surface) {
        let collisionPoint:Vector = s.getCoordsCorrespondingToXAndYWithAngle(b.x,y: b.y)//Gets point on surface closest to the ball
        if (b.x-collisionPoint.x >= 0) {//if ball is on the right side of the surface, move right
            b.x = collisionPoint.x + b.r * cos((90*(M_PI/180))-s.angle)
        }
        else {//otherwise, move left
            b.x = collisionPoint.x - b.r * cos((90*(M_PI/180))-s.angle)
        }
        if (b.y-collisionPoint.y >= 0) {//If ball is below, move down (to a higher y value)
            b.y = (collisionPoint.y + b.r * sin((90*(M_PI/180)) - s.angle))
        }
        else {//otherwise, move up
            b.y = (collisionPoint.y - b.r * sin((90*(M_PI/180)) - s.angle))
        }
    }
    
    func bounce(s:Surface, ball:Ball) {//Reflect ball's velocity over the vector of the surface, using Doubles for more precision
        //println("Bouncing")
        //Taken from here:http: //stackoverflow.com/questions/14885693/how-do-you-reflect-a-vector-over-another-vector
        let vec1:Vector =  Vector(x: ball.vx, y: ball.vy);
        let vec2:Vector = s.getSurfaceVector();
    
        // 1. Find the dot product of vec1 and vec2
        // Note: dx and dy are vx and vy divided over the length of the vector (magnitude)
        var dpA:Double = vec1.x * vec2.unitVector().x + vec1.y * vec2.unitVector().y;
        
        // 2. Project vec1 over vec2
        var prA_vx:Double = dpA * vec2.unitVector().x;
        var prA_vy:Double = dpA * vec2.unitVector().y;
        
        // 3. Find the dot product of vec1 and vec2's normal
        // (left or right normal depending on line's direction, let's say left)
        var dpB:Double = vec1.x * vec2.leftNormal().unitVector().x + vec1.y * vec2.leftNormal().unitVector().y;
        
        // 4. Project vec1 over vec2's left normal
        var prB_vx:Double = dpB * vec2.leftNormal().unitVector().x;
        var prB_vy:Double = dpB * vec2.leftNormal().unitVector().y;
        //println(vec2.leftNormal().unitVector().y)
        // 5. Add the first projection prA to the reverse of the second -prB
        var new_vx:Double = prA_vx - prB_vx;
        var new_vy:Double = prA_vy - prB_vy;
        
        let v = Vector(x: new_vx, y: new_vy)
        let velocityAwayFromSpring = v.projectOnto(s.getSurfaceVector().leftNormal())
        let newVAFS = Vector.multiply(s.bounceCoefficient, v: velocityAwayFromSpring)
        var diffAngle = acos((Vector.dotP(v, v2: velocityAwayFromSpring)/(v.getMagnitude()*velocityAwayFromSpring.getMagnitude())))
        
        println(diffAngle*(180/M_PI))
        let y2 = Vector.subtract(v, velocityAwayFromSpring)
        let newV = Vector.add(y2, newVAFS)
        ball.vx = newV.x
        ball.vy = newV.y
    }
    
    class func gameLayoutArray() -> [LevelLayout] {
        let gla:[LevelLayout] = [LevelLayout(g: [Spring(f: true, points: (Vector(x: 50, y:100), Vector(x: Double(UIScreen.mainScreen().bounds.width), y: 250))), Surface(fixed: true, points: (Vector(x: 100, y:120), Vector(x: 150, y: 250)))], movingBlackHoles: 0, movingSprings: 0, movingSurfaces: 0)]
        return gla
        //, Spring(f: true, points: (Vector(x: 500,y: 200),Vector(x: 600,y: 200)))
    }
    
}