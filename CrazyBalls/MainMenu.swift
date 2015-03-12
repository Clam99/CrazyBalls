import Foundation
import UIKit

class MainMenu: UIView {
    var balls:[Ball] = []
    var timerCount = 0
    let timer:NSTimer!
    var delegate:TargetDelegate?
    
    init(frame:CGRect) {
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerFunc" repeats: true)
        title.alpha = 0.0
        playBut.alpha = 0.0
        highscoreText.alpha = 0.0
        super.init(frame)
    }
    func timerFunc() {
        timerCount++
        if (timerCount >= 2) {
            balls.append(Ball(x:0, y:0, radius:50,radiansCounterClockwiseFromHorizontal:arc4random()%(30*(M_PI/180)), initialVelocity: 10))// - append balls facing in random directions
            balls.append(Ball(x:0, y:0, radius:50,radiansCounterClockwiseFromHorizontal:arc4random()%(30*(M_PI/180))+30, initialVelocity: 10))// - append balls facing in random directions
            balls.append(Ball(x:0, y:0, radius:50,radiansCounterClockwiseFromHorizontal:arc4random()%(30*(M_PI/180))+60, initialVelocity: 10))// - append balls facing in random directions
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
        NSTimer.scheduledTimerWithTimeInterval(0.7, target: self, selector: "showMenu" repeats: false)
        showMenu()
    }
    func showMenu() {
        delegate.recieveAction(ButtonLayout.allShown.rawValue)
    }
}