import Foundation
import UIKit

class MainMenu: UIView {
    var balls:[Ball]! = []
    var timerCount = 0
    var timer:Timer!
    var delegate:TargetDelegate!
    let maxCount = 50
    var paragraphStyle:NSMutableParagraphStyle
    var play = UIButton(type:UIButtonType.system)
    var h:UILabel = UILabel()
    var title:UILabel = UILabel()
    var radius:Double = 50
    
    override init(frame:CGRect) {
        paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        super.init(frame: frame)
        backgroundColor = UIColor.white
        isOpaque = false
        _ = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(MainMenu.timerFunc), userInfo: nil, repeats: true)
    }

    required init(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        super.init(coder: aDecoder)!//Check this
        backgroundColor = UIColor.white
        isOpaque = false
        timer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(MainMenu.timerFunc), userInfo: nil, repeats: true)
    }

    
    func timerFunc() {
        timerCount += 1
        for ball in balls {
            ball.updateVelocity()
            ball.updatePos()
        }
        if (timerCount%2 == 0 && timerCount<maxCount) {
        balls.append(createBallBetweenDegrees(-30.0, max:0.0)) // - append balls facing in random directions

        balls.append(createBallBetweenDegrees(-60.0, max:-30.0)) // - append balls facing in random directions
        balls.append(createBallBetweenDegrees(-90.0, max:0)) // - append balls facing in random directions
        balls.append(createBallBetweenDegrees(-60.0, max:0.0))
        balls.append(createBallBetweenDegrees(-60.0, max:0.0))

        }
        else if (timerCount==maxCount) {
            Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(MainMenu.stopTimer), userInfo: nil, repeats: false)
            showTitle()
        }
        
        setNeedsDisplay()
    }
    
    func createBallBetweenDegrees(_ min:Double, max:Double) -> Ball {
        return Ball(x:0.0, y:0.0, radius:radius, radiansCounterClockwiseFromHorizontal:(Double(arc4random()).truncatingRemainder(dividingBy: ((max-min)*(Double.pi/180)))+(min)*(Double.pi/180)), initialVelocity: 10)
    }


    func stopTimer() {
        if let t = timer {
            t.invalidate()
            timer = nil
            balls = nil
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect:CGRect) {
        if (balls != nil) {
            for ball in balls {
                let circle = UIBezierPath(arcCenter: CGPoint(x: CGFloat(ball.x), y: CGFloat(ball.y)), radius: CGFloat(ball.r), startAngle: 0, endAngle: 7, clockwise: true)
                
                UIColor.black.setFill()
                circle.fill()
            }
        }
        else {
            //super.drawRect(rect)
            //println("in drawRect")
        }
    }
    func showTitle() {
        //println("in showTitle")
        title.frame = CGRect(x: 0, y: frame.size.height/6, width: frame.size.width, height: frame.size.height/3)
        
        title.attributedText = NSAttributedString(string: "Crazy Balls", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: frame.size.width/8), NSParagraphStyleAttributeName: paragraphStyle])
        title.alpha = 0.0
        addSubview(title)
        UIView.animate(withDuration: 0.2, animations: {
                self.title.alpha = 1.0
                self.setNeedsDisplay()
            })
        setNeedsDisplay()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(MainMenu.showMenu), userInfo: nil, repeats: false)
      
    }
    func showMenu() {
       // delegate.receiveAction(ButtonLayout.allShown.rawValue)

        h.attributedText = NSAttributedString(string: "highscore: 0", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: frame.size.width/40), NSParagraphStyleAttributeName:paragraphStyle])
        h.sizeToFit()
        h.frame = CGRect(x: frame.size.width/2-h.frame.size.width/2, y: 5*frame.size.height/9, width: h.frame.size.width, height: h.frame.size.height)
        h.alpha = 0.0
        addSubview(h)
        play.setTitle("play", for: UIControlState())
        play.titleLabel?.font = UIFont.systemFont(ofSize: frame.size.width/15)
        play.sizeToFit()
        play.frame = CGRect(x: frame.size.width/2-play.frame.size.width/2, y: 6*frame.size.height/9, width: play.frame.size.width, height: play.frame.size.height)
        play.alpha = 0.0
        play.addTarget(self, action: #selector(MainMenu.playPressed), for: UIControlEvents.touchUpInside)
        addSubview(play)
        UIView.animate(withDuration: 1, animations: {
            self.play.alpha = 1.0
            self.h.alpha = 1.0
        })
    }
    func playPressed() {
        //println("pressed! Yayayayya")
        UIView.animate(withDuration: 1, animations: {
            self.title.alpha = 0.0
            self.h.alpha = 0.0
            let frame = self.play.frame
            self.play.frame = CGRect(x: frame.origin.x, y: -frame.size.height, width: frame.size.width, height: frame.size.height)
            },
            completion: {finished in
                let view:View = View(frame: self.frame)
                self.addSubview(view)
        });
        UIView.animate(withDuration: 1, animations: {
            self.title.alpha = 0.0
            self.h.alpha = 0.0
            let frame = self.play.frame
            self.play.frame = CGRect(x: frame.origin.x, y: -frame.size.height, width: frame.size.width, height: frame.size.height)
        })
        setNeedsDisplay()
    }
}
