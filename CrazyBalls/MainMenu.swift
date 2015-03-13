import Foundation
import UIKit

class MainMenu: UIView {
    var balls:[Ball]! = []
    var timerCount = 0
    var timer:NSTimer!
    var delegate:TargetDelegate!
    let maxCount = 100
    var paragraphStyle:NSMutableParagraphStyle
    var play = UIButton.buttonWithType(UIButtonType.System) as UIButton
    var h:UILabel = UILabel()
    var title:UILabel = UILabel()
    var radius:Double = Double(UIScreen.mainScreen().bounds.size.height)/6.6
    
    override init(frame:CGRect) {
        paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Center
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        opaque = false
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerFunc", userInfo: nil, repeats: true)
    }

    required init(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Center
        super.init(coder: aDecoder)
        backgroundColor = UIColor.whiteColor()
        opaque = false
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerFunc", userInfo: nil, repeats: true)
    }

    
    func timerFunc() {
        timerCount++
        for ball in balls {
            ball.updateVelocity()
            ball.updatePos()
        }
        if (timerCount%2 == 0 && timerCount<maxCount) {
        balls.append(createBallBetweenDegrees(-30.0, max:0.0)) // - append balls facing in random directions

        balls.append(createBallBetweenDegrees(-60.0, max:-30.0)) // - append balls facing in random directions
        balls.append(createBallBetweenDegrees(-90.0, max:-60.0)) // - append balls facing in random directions

            balls.append(createBallBetweenDegrees(-60.0, max:0.0))

        }
        else if (timerCount==maxCount) {
            NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: "stopTimer", userInfo: nil, repeats: false)
            showTitle()
        }
        
        setNeedsDisplay()
    }
    
    func createBallBetweenDegrees(min:Double, max:Double) -> Ball {
        return Ball(x:0, y:0, radius:radius,radiansCounterClockwiseFromHorizontal:(Double(arc4random())%((max-min)*(M_PI/180))+(min)*(M_PI/180)), initialVelocity: 10)
    }


    func stopTimer() {
        if let t = timer {
            t.invalidate()
            timer = nil
            balls = nil
            setNeedsDisplay()
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
        else {
            //super.drawRect(rect)
            println("in drawRect")
        }
    }
    func showTitle() {
        println("in showTitle")
        title.frame = CGRectMake(0, frame.size.height/6, frame.size.width, frame.size.height/3)
        
        title.attributedText = NSAttributedString(string: "Crazy Balls", attributes: [NSFontAttributeName:UIFont.systemFontOfSize(frame.size.width/8), NSParagraphStyleAttributeName: paragraphStyle])
        title.alpha = 0.0
        addSubview(title)
        UIView.animateWithDuration(0.2, animations: {
                self.title.alpha = 1.0
                self.setNeedsDisplay()
            })
        setNeedsDisplay()
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "showMenu", userInfo: nil, repeats: false)
      
    }
    func showMenu() {
       // delegate.receiveAction(ButtonLayout.allShown.rawValue)

        h.attributedText = NSAttributedString(string: "highscore: 0", attributes: [NSFontAttributeName:UIFont.systemFontOfSize(frame.size.width/40), NSParagraphStyleAttributeName:paragraphStyle])
        h.sizeToFit()
        h.frame = CGRectMake(frame.size.width/2-h.frame.size.width/2, 5*frame.size.height/9, h.frame.size.width, h.frame.size.height)
        h.alpha = 0.0
        addSubview(h)
        play.setTitle("play", forState: UIControlState.Normal)
        play.titleLabel?.font = UIFont.systemFontOfSize(frame.size.width/15)
        play.sizeToFit()
        play.frame = (frame: CGRectMake(frame.size.width/2-play.frame.size.width/2, 6*frame.size.height/9, play.frame.size.width, play.frame.size.height))
        play.alpha = 0.0
        play.addTarget(self, action: "playPressed", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(play)
        UIView.animateWithDuration(1, animations: {
            self.play.alpha = 1.0
            self.h.alpha = 1.0
        })
    }
    func playPressed() {
        println("pressed! Yayayayya")
        UIView.animateWithDuration(1, animations: {
            self.title.alpha = 0.0
            self.h.alpha = 0.0
            let frame = self.play.frame
            self.play.frame = CGRectMake(frame.origin.x, -frame.size.height, frame.size.width, frame.size.height)
            },
            completion: {finished in
                let view:View = View(frame: self.frame)
                self.addSubview(view)
        });
        UIView.animateWithDuration(1, animations: {
            self.title.alpha = 0.0
            self.h.alpha = 0.0
            let frame = self.play.frame
            self.play.frame = CGRectMake(frame.origin.x, -frame.size.height, frame.size.width, frame.size.height)
        })
        setNeedsDisplay()
    }
}