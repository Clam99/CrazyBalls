import Foundation
import UIKit

class MainMenu: UIView {
    var balls:[Ball] = []
    var timerCount = 0
    var timer:NSTimer!
    var delegate:TargetDelegate?
    
    override init(frame:CGRect) {
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerFunc", userInfo: nil, repeats: true)
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func timerFunc() {
        timerCount++
        if (timerCount >= 2) {
            let c:Double = Double(arc4random())%(30*(M_PI/180))
            balls.append(Ball(x: 0.0, y: 0.0, radius: 50.0, radiansCounterClockwiseFromHorizontal: c, initialVelocity: 10))// - append balls facing in random directions
            balls.append(Ball(x:0, y:0, radius:50,radiansCounterClockwiseFromHorizontal:(Double(arc4random())%(30*(M_PI/180))+30), initialVelocity: 10))// - append balls facing in random directions
            balls.append(Ball(x:0, y:0, radius:50,radiansCounterClockwiseFromHorizontal:Double(arc4random())%(30*(M_PI/180))+60, initialVelocity: 10))// - append balls facing in random directions
        }
        if (timerCount>=3000) {
            timer.invalidate()
            timer = nil
            showTitle()
        }
        
        setNeedsDisplay()
    }
    override func drawRect(rect:CGRect) {
        for ball in balls {
            let circle = UIBezierPath(arcCenter: CGPointMake(CGFloat(ball.x), CGFloat(ball.y)), radius: CGFloat(ball.r), startAngle: 0, endAngle: 7, clockwise: true)
            
            UIColor.blackColor().setFill()
            circle.fill()
        }
    }
    func showTitle() {
        delegate.recieveAction(ButtonLayout.justTitle.rawValue)
        NSTimer.scheduledTimerWithTimeInterval(0.7, target: self, selector: "showMenu", repeats: false)
        showMenu()
    }
    func showMenu() {
        delegate.recieveAction(ButtonLayout.allShown.rawValue)
    }
}