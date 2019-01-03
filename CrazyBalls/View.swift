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
    var timer:Timer!
    var gameRunning = false
    var isSelecting = false
    var dragVector:Vector?
    var isDragging = false
    let c = 0.06
    let reset:UIButton = UIButton(type:UIButtonType.system)
    var timer2:Timer!
    var labelShown:Bool = false
    var maxPullBack:Double = Double(UIScreen.main.bounds.width)/3
    
    override init(frame:CGRect) {
        logic = GameLogic(frame: frame)
        super.init(frame: frame)
        logic.delegate = self
        self.isOpaque = false
        self.backgroundColor = UIColor.clear
        startSelection()
        
        let buttonWidth = UIScreen.main.bounds.width/7
        let buttonHeight = UIScreen.main.bounds.height/10
        reset.frame = CGRect(x: UIScreen.main.bounds.width-buttonWidth-20, y: 20, width: buttonWidth, height: buttonHeight)
        addSubview(reset)
        reset.addTarget(self, action: #selector(View.resetFunc), for: UIControlEvents.touchUpInside)
        reset.setTitle("Reset", for: UIControlState())
        reset.titleLabel?.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.width/30)
    }
    
    func startSelection() {//here user places objects and then pulls back and releases the ball
        isSelecting = true
        //startGame()//should be taken out
    }
    
    func resetFunc() {
        if let s = self.superview {
            s.addSubview(View(frame: frame))
        }
        if let t = timer {
            t.invalidate()
        }
        removeFromSuperview()
    }
    
    func startGame(_ shootX:Double, shootY:Double) {
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(View.update), userInfo: nil, repeats: true)
        gameRunning = true
        isSelecting = false
        logic.balls[0].vx = shootX*c
        logic.balls[0].vy = shootY*c
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        for ball in logic.balls {
            let circle = UIBezierPath(arcCenter: CGPoint(x: CGFloat(ball.x), y: CGFloat(ball.y)), radius: CGFloat(ball.r), startAngle: 0, endAngle: 7, clockwise: true)
            
            UIColor.black.setFill()
            circle.fill()
        }
        for obj in logic.ll.fixedObjects {
            if let d = obj.done {
                if (d) {
                    UIColor.green.setStroke()
                }
                else {
                    UIColor.purple.setStroke()
                }
            }
            else {
                UIColor.red.setStroke()
            }
            obj.getBP().stroke()
            
        }
        if (isDragging) {
            let ctx:CGContext = UIGraphicsGetCurrentContext()!
            
            ctx.setLineWidth(10)
            ctx.setStrokeColor(UIColor.blue.cgColor)
            ctx.beginPath()
            ctx.move(to: CGPoint(x: CGFloat(logic.balls[0].x), y: CGFloat(logic.balls[0].y)))
            ctx.addLine(to: CGPoint(x: CGFloat(logic.balls[0].x+(logic.balls[0].x-dragVector!.x)), y: CGFloat(logic.balls[0].y+(logic.balls[0].y-dragVector!.y))))
            ctx.strokePath()
        }
        let goal = UIBezierPath(arcCenter: logic.ll.goal, radius: CGFloat(logic.ll.goalRadius), startAngle: 0, endAngle: 7, clockwise: true)
        UIColor.green.setStroke()
        goal.lineWidth = 5
        goal.stroke()
        UIColor.white.setFill()
        goal.fill()
    }
    
    func update() {
        logic.updateLogic()
        setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //println("in touchesBegan")
        if let touch = touches.first {
            if (isSelecting && Double(touch.location(in: self).x) > logic.balls[0].x-logic.radius && Double(touch.location(in: self).x) < logic.balls[0].x+logic.radius && Double(touch.location(in: self).y) > logic.balls[0].y-logic.radius && Double(touch.location(in: self).x) < logic.balls[0].x+logic.radius) {
                //println("User is dragging the ball")
                dragVector = Vector(x: Double(touch.location(in: self).x), y: Double(touch.location(in: self).y))
                isDragging = true
                setNeedsDisplay()
            }
        }
        super.touchesBegan(touches, with:event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if (isDragging) {
                //println("You seem to be moving it.  you are at an x val of \(Double(touch.locationInView(self).x))")
                if ((dragVector) != nil) {
                    dragVector!.x = Double(touch.location(in: self).x)
                }
                if (dragVector != nil) {
                    dragVector!.y = Double(touch.location(in: self).y)
                }
                let v = Vector.subtract(dragVector!, v2: Vector(x: logic.balls[0].x, y: logic.balls[0].y))
                if (dragVector != nil && v.getMagnitude() > maxPullBack) {
                    v.setMagnitude(maxPullBack)
                    dragVector = Vector.add(v, v2: Vector(x: logic.balls[0].x, y: logic.balls[0].y))
                    //println("You've gone too far")
                }
                setNeedsDisplay()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDragging = false
        setNeedsDisplay()
        if (dragVector != nil) {
            startGame((logic.balls[0].x-dragVector!.x), shootY: (logic.balls[0].y-dragVector!.y))
        }
        dragVector = nil
    }
    
    func receiveAction(_ passedData: String) {
        if passedData == logic.wonString {
            showWonMessage()
        }
    }
    
    func showWonMessage() {
        timer2 = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(View.increaseCircle), userInfo: nil, repeats: true)
        
    }
    
    func increaseCircle() {
        logic.ll.goalRadius += Double(UIScreen.main.bounds.width)/32.0
        if (logic.ll.goalRadius >= Double(UIScreen.main.bounds.width*0.8) && !labelShown) {
            let label = UILabel(frame: self.frame)
            label.alpha = 0.0
            let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.center
            label.attributedText = NSAttributedString(string: "clear", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: UIScreen.main.bounds.width/7), NSParagraphStyleAttributeName: paragraphStyle])
            self.addSubview(label)
            UIView.animate(withDuration: 0.5, animations: {
                //println("showing label")
                label.alpha = 1.0
            })
            labelShown = true
        }
        if (logic.ll.goalRadius >= Double(UIScreen.main.bounds.width*1.2)) {
            timer2.invalidate()
            timer.invalidate()
        }
    }
}
