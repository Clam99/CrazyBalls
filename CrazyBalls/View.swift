//
//  View.swift
//  HardThing
//
//  Created by Sam Noyes on 3/7/15.
//  Copyright (c) 2015 Sam Noyes. All rights reserved.
//


import Foundation
import UIKit


class View: UIView, TargetDelegate {
    var logic:GameLogic
    var timer:NSTimer!
    var gameRunning = false
    var isSelecting = false
    var dragVector:Vector?
    var isDragging = false
    let c = 0.06
    let reset:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    var timer2:NSTimer!
    var labelShown:Bool = false
    var maxPullBack:Double = Double(UIScreen.mainScreen().bounds.width)/10.0
    
    override init(frame:CGRect) {
        logic = GameLogic(frame: frame)
        super.init(frame: frame)
        logic.delegate = self
        self.opaque = false
        self.backgroundColor = UIColor.clearColor()
        startSelection()
        
        let buttonWidth = UIScreen.mainScreen().bounds.width/7
        let buttonHeight = UIScreen.mainScreen().bounds.height/10
        reset.frame = CGRectMake(UIScreen.mainScreen().bounds.width-buttonWidth-20, 20, buttonWidth, buttonHeight)
        addSubview(reset)
        reset.addTarget(self, action: "resetFunc", forControlEvents: UIControlEvents.TouchUpInside)
        reset.setTitle("Reset", forState: UIControlState.Normal)
        reset.titleLabel?.font = UIFont.systemFontOfSize(UIScreen.mainScreen().bounds.width/30)
    }
    
    func startSelection() {//here user places objects and then pulls back and releases the ball
        isSelecting = true
        //startGame()//should be taken out
    }
    
    func resetFunc() {
        if let s = self.superview {
            s.addSubview(View(frame: frame))
        }
        if var t = timer {
            t.invalidate()
        }
        removeFromSuperview()
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
        for obj in logic.ll.fixedObjects {
            if let d = obj.done {
                if (d) {
                    UIColor.greenColor().setStroke()
                }
                else {
                    UIColor.purpleColor().setStroke()
                }
            }
            else {
                UIColor.redColor().setStroke()
            }
            obj.getBP().stroke()
            
        }
        if (isDragging) {
            let ctx:CGContext = UIGraphicsGetCurrentContext()
            
            CGContextSetLineWidth(ctx, 10)
            CGContextSetStrokeColorWithColor(ctx, UIColor.blueColor().CGColor)
            CGContextBeginPath(ctx)
            CGContextMoveToPoint(ctx, CGFloat(logic.balls[0].x), CGFloat(logic.balls[0].y))
            CGContextAddLineToPoint(ctx, CGFloat(logic.balls[0].x+(logic.balls[0].x-dragVector!.x)), CGFloat(logic.balls[0].y+(logic.balls[0].y-dragVector!.y)))
            CGContextStrokePath(ctx)
        }
        let goal = UIBezierPath(arcCenter: logic.ll.goal, radius: CGFloat(logic.ll.goalRadius), startAngle: 0, endAngle: 7, clockwise: true)
        UIColor.greenColor().setStroke()
        goal.lineWidth = 5
        goal.stroke()
        UIColor.whiteColor().setFill()
        goal.fill()
    }
    
    func update() {
        logic.updateLogic()
        setNeedsDisplay()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        //println("in touchesBegan")
        let touch:UITouch = touches.anyObject() as UITouch
        if (isSelecting && Double(touch.locationInView(self).x) > logic.balls[0].x-logic.radius && Double(touch.locationInView(self).x) < logic.balls[0].x+logic.radius && Double(touch.locationInView(self).y) > logic.balls[0].y-logic.radius && Double(touch.locationInView(self).x) < logic.balls[0].x+logic.radius) {
            //println("User is dragging the ball")
            dragVector = Vector(x: Double(touch.locationInView(self).x), y: Double(touch.locationInView(self).y))
            isDragging = true
            setNeedsDisplay()
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch:UITouch = touches.anyObject() as UITouch
        if (isDragging) {
            //println("You seem to be moving it.  you are at an x val of \(Double(touch.locationInView(self).x))")
            if ((dragVector) != nil) {
                dragVector!.x = Double(touch.locationInView(self).x)
            }
            if (dragVector != nil) {
                dragVector!.y = Double(touch.locationInView(self).y)
            }
            if (dragVector != nil && dragVector!.getMagnitude() > maxPullBack) {
                dragVector!.setMagnitude(maxPullBack)
            }
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        isDragging = false
        setNeedsDisplay()
        if (dragVector != nil) {
            startGame((logic.balls[0].x-dragVector!.x), shootY: (logic.balls[0].y-dragVector!.y))
        }
        dragVector = nil
    }
    
    func receiveAction(passedData: String) {
        if passedData == logic.wonString {
            showWonMessage()
        }
    }
    
    func showWonMessage() {
        timer2 = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: "increaseCircle", userInfo: nil, repeats: true)
        
    }
    
    func increaseCircle() {
        logic.ll.goalRadius += Double(UIScreen.mainScreen().bounds.width)/32.0
        if (logic.ll.goalRadius >= Double(UIScreen.mainScreen().bounds.width*0.8) && !labelShown) {
            let label = UILabel(frame: self.frame)
            label.alpha = 0.0
            let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.Center
            label.attributedText = NSAttributedString(string: "clear", attributes: [NSFontAttributeName:UIFont.systemFontOfSize(UIScreen.mainScreen().bounds.width/7), NSParagraphStyleAttributeName: paragraphStyle])
            self.addSubview(label)
            UIView.animateWithDuration(0.5, animations: {
                //println("showing label")
                label.alpha = 1.0
            })
            labelShown = true
        }
        if (logic.ll.goalRadius >= Double(UIScreen.mainScreen().bounds.width*1.2)) {
            timer2.invalidate()
            timer.invalidate()
        }
    }
}
