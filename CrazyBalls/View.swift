//
//  View.swift
//  HardThing
//
//  Created by Sam Noyes on 3/7/15.
//  Copyright (c) 2015 Sam Noyes. All rights reserved.
//


import Foundation
import UIKit


class View: UIView {
    let logic:GameLogic
    var timer:NSTimer!
    var gameRunning = false
    var isSelecting = false
    var dragX:Double?
    var dragY:Double?
    var isDragging = false
    let c = 0.06
    
    override init(frame:CGRect) {
        logic = GameLogic(frame: frame)
        super.init(frame: frame)
        self.opaque = false
        self.backgroundColor = UIColor.clearColor()
        startSelection()
    }
    
    func startSelection() {//here user places objects and then pulls back and releases the ball
        isSelecting = true
        //startGame()//should be taken out
    }
    
    func startGame(shootX:Double, shootY:Double) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: "update", userInfo: nil, repeats: true)
        gameRunning = true
        isSelecting = false
        logic.balls[0].vx = shootX*c
        logic.balls[0].vy = shootY*c
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        for ball in logic.balls {
            let circle = UIBezierPath(arcCenter: CGPointMake(CGFloat(ball.x), CGFloat(ball.y)), radius: CGFloat(ball.r), startAngle: 0, endAngle: 7, clockwise: true)
            
            UIColor.blackColor().setFill()
            circle.fill()
        }
        for surface in logic.ll.surfaces {
            
            let ctx:CGContext = UIGraphicsGetCurrentContext()
            
            CGContextSetLineWidth(ctx, 10)
            CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
            CGContextBeginPath(ctx)
            CGContextMoveToPoint(ctx, CGFloat(surface.points.0.x), CGFloat(surface.points.0.y))
            CGContextAddLineToPoint(ctx, CGFloat(surface.points.1.x), CGFloat(surface.points.1.y))
            CGContextStrokePath(ctx)
        }
        if (isDragging) {
            let ctx:CGContext = UIGraphicsGetCurrentContext()
            
            CGContextSetLineWidth(ctx, 10)
            CGContextSetStrokeColorWithColor(ctx, UIColor.blueColor().CGColor)
            CGContextBeginPath(ctx)
            CGContextMoveToPoint(ctx, CGFloat(logic.balls[0].x), CGFloat(logic.balls[0].y))
            CGContextAddLineToPoint(ctx, CGFloat(logic.balls[0].x+(logic.balls[0].x-dragX!)), CGFloat(logic.balls[0].y+(logic.balls[0].y-dragY!)))
            CGContextStrokePath(ctx)
        }
    }
    
    func update() {
        logic.updateLogic()
        setNeedsDisplay()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        println("in touchesBegan")
        let touch:UITouch = touches.anyObject() as UITouch
        if (isSelecting && Double(touch.locationInView(self).x) > logic.balls[0].x-logic.radius && Double(touch.locationInView(self).x) < logic.balls[0].x+logic.radius && Double(touch.locationInView(self).y) > logic.balls[0].y-logic.radius && Double(touch.locationInView(self).x) < logic.balls[0].x+logic.radius) {
            //println("User is dragging the ball")
            dragX = Double(touch.locationInView(self).x)
            dragY = Double(touch.locationInView(self).y)
            isDragging = true
            setNeedsDisplay()
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch:UITouch = touches.anyObject() as UITouch
        if (isDragging) {
            //println("You seem to be moving it.  you are at an x val of \(Double(touch.locationInView(self).x))")
            if ((dragX) != nil) {
                dragX = Double(touch.locationInView(self).x)
            }
            if (dragY != nil) {
                dragY = Double(touch.locationInView(self).y)
            }
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        isDragging = false
        setNeedsDisplay()
        if (dragX != nil && dragY != nil) {
            startGame((logic.balls[0].x-dragX!), shootY: (logic.balls[0].y-dragY!))
        }
        dragX = nil
        dragY = nil
    }
    
}
