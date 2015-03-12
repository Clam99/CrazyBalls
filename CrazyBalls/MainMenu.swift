import Foundation
import UIKit

class MainMenu: UIView {
    var balls:[Ball]! = []
    var timerCount = 0
    var timer:NSTimer!
    var delegate:TargetDelegate!
    let maxCount = 100
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        opaque = false
        println("Making it")
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerFunc", userInfo: nil, repeats: true)
    }

    required init(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        backgroundColor = UIColor.whiteColor()
        opaque = false
        println("Making it")
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerFunc", userInfo: nil, repeats: true)
    }

    
    func timerFunc() {
        timerCount++
        for ball in balls {
            ball.updateVelocity()
            ball.updatePos()
        }
        if (timerCount%2 == 0 && timerCount<maxCount) {
            let c:Double = Double(arc4random())%(30*(M_PI/180))
            balls.append(createBallBetweenDegrees(min:-30.0, max:0.0)// - append balls facing in random directions
            balls.append(createBallBetweenDegrees(min:-60.0, max:-30.0)// - append balls facing in random directions
            balls.append(createBallBetweenDegrees(min:-90.0, max:-60.0))// - append balls facing in random directions

balls.append(createBallBetweenDegrees(min:-90.0, max:0.0))
        }
        else if (timerCount>=maxCount) {
            println("Stopping")
            NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "stopTimer", userInfo: nil, repeats: false)
            showTitle()
        }
        
        setNeedsDisplay()
    }
    
func createBallBetweenDegrees(min:Double max:Double) -> Ball {
return Ball(x:0, y:0, radius:50,radiansCounterClockwiseFromHorizontal:(Double(arc4random())%((max-min)*(M_PI/180))+(min)*(M_PI/180)), initialVelocity: 10)
}


    func stopTimer() {
        if let t = timer {
            t.invalidate()
            timer = nil
            balls = nil
        }
    }
    
    override func drawRect(rect:CGRect) {
        if (balls != nil) {
            for ball in balls {
                let circle = UIBezierPath(arcCenter: CGPointMake(CGFloat(ball.x), CGFloat(ball.y)), radius: CGFloat(ball.r), startAngle: 0, endAngle: 7, clockwise: true)
                
                UIColor.blackColor().setFill()
                circle.fill()
            }
        }
    }
    func showTitle() {
        let l:UILabel = UILabel(frame: CGRectMake(frame.size.width/4, frame.size.height/4, frame.size.width/2, frame.size.height/2))
        l.attributedText = NSAttributedString(string: "Crazy Balls", attributes: [NSFontAttributeName:UIFont.systemFontOfSize(frame.size.width/10)])
        l.alpha = 0.0
        addSubview(l)
        UIView.animateWithDuration(1, animations: {
                l.alpha = 1.0
            })
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "showMenu", userInfo: nil, repeats: false)
      
    }
    func showMenu() {
       // delegate.receiveAction(ButtonLayout.allShown.rawValue)

        let h:UILabel = UILabel(frame: CGRectMake(2*frame.size.width/3, frame.size.height/4, frame.size.width/2, frame.size.height/2))
        h.attributedText = NSAttributedString(string: "Highscore: 0", attributes: [NSFontAttributeName:UIFont.systemFontOfSize(frame.size.width/40)])
        h.alpha = 0.0
        addSubview(h)
        let l:UIButton = UIButton(frame: CGRectMake(frame.size.width/4, 4*frame.size.height/5, frame.size.width/2, frame.size.height/2))
        l.setTitle("Play!", forState: UIControlState.Normal)
        l.alpha = 0.0
        addSubview(l)
        UIView.animateWithDuration(1, animations: {
            l.alpha = 1.0
            h.alpha = 1.0
        })
    }
}