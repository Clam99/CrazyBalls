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
    let timer:NSTimer!
    var gameRunning = false
    var isSelecting = false
    
    override init(frame:CGRect) {
        logic = GameLogic(frame: frame)
        super.init(frame: frame)
        self.opaque = false
        self.backgroundColor = UIColor.clearColor()
        startSelection()
    }
    
    func startSelection() {\\here user places objects and then pulls back and releases the ball
        isSelecting = true
    }
    
    func startGame() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: "update", userInfo: nil, repeats: true)
        gameRunning = true
        isSelecting = false
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
        for surface in logic.surfaces {
            
            let ctx:CGContext = UIGraphicsGetCurrentContext()
            
            CGContextSetLineWidth(ctx, 10)
            CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
            CGContextBeginPath(ctx)
            CGContextMoveToPoint(ctx, CGFloat(surface.points.0.x), CGFloat(surface.points.0.y))
            CGContextAddLineToPoint(ctx, CGFloat(surface.points.1.x), CGFloat(surface.points.1.y))
            CGContextStrokePath(ctx)
        }
    }
    
    func update() {
        logic.updateLogic()
        setNeedsDisplay()
        setFrame(superview().frame)
    }
    
    
}
