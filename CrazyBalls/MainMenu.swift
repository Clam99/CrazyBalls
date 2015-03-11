import Foundation
import UIKit

class MainMenu: UIView
    var balls:[Ball] = []
    var timerCount = 0
    override init() {
        NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerFunc" repeats: true)
    }
    func timerFunc() {
        timerCount++
        if (timerCount >= 10) {
            timerCount = 0
            balls.append(Ball(x:0, y:0, radius:50,radiansCounterClockwiseFromHorizontal:arc4random()%(30*(M_PI/180)), initialVelocity: 10))// - append balls facing in random directions
            balls.append(Ball(x:0, y:0, radius:50,radiansCounterClockwiseFromHorizontal:arc4random()%(30*(M_PI/180))+30, initialVelocity: 10))// - append balls facing in random directions
            balls.append(Ball(x:0, y:0, radius:50,radiansCounterClockwiseFromHorizontal:arc4random()%(30*(M_PI/180))+60, initialVelocity: 10))// - append balls facing in random directions
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
}