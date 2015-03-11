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
    var balls:[Ball] = [Ball(x:50, y: 75, radius: 25)]
    var surfaces:[Surface]
    
    init(frame:CGRect) {
        self.frame = frame
        surfaces = [Surface(fixed: true, points: (Vector(x: 0, y:150), Vector(x: Double(frame.size.width), y: 300)))]
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
            for surface in surfaces {
                if surface.isTouchingBall(ball) {
                    bounce(surface,ball: ball)
                    moveBallOut(ball, s: surface)
                }
            }
        }
    }
    
    func moveBallOut(b:Ball, s:Surface) {
        b.x = s.getCoordsCorrespondingToXAndYWithAngle(b.x, y: b.y).x+b.r*sin(s.angle)
        b.y = s.getCoordsCorrespondingToXAndYWithAngle(b.x, y: b.y).y-b.r*cos(s.angle)
    }
    
    func bounce(s:Surface, ball:Ball) {//Reflect ball's velocity over the vector of the surface, using Doubles for more precision
    
        //Taken from here:http: //stackoverflow.com/questions/14885693/how-do-you-reflect-a-vector-over-another-vector
        //println("Bouncing")
        let vec1:Vector =  Vector(x: ball.vx, y: ball.vy);
        let vec2:Vector = s.getSurfaceVector();
        
        //println(ball.vx)
        //println(ball.vy)
        //println(s.getSurfaceVector().x)
        //println(s.getSurfaceVector().y)
    
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
        //println("dpB = \(dpB)")
        //println(vec2.leftNormal().unitVector().y)
        // 5. Add the first projection prA to the reverse of the second -prB
        var new_vx:Double = prA_vx - prB_vx;
        var new_vy:Double = prA_vy - prB_vy;
        
        //println(new_vx)
        //println(new_vy)
        
        ball.vx = new_vx
        ball.vy = new_vy
    }
}