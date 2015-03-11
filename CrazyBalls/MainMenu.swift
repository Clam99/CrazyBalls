import Foundation
import UIKit

class MainMenu: UIViewController
    var balls:[Ball] = []
    var timerCount = 0
    let timer:NSTimer!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var playBut: UIButton!
    @IBOutlet weak var highscoreText: UILabel!
    
    override func viewDidLoad() {
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerFunc" repeats: true)
        title.alpha = 0.0
        playBut.alpha = 0.0
        highscoreText.alpha = 0.0
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
        UIView.animateWithDuration(1.5, animations: {
            label.alpha = 1.0
        })
        showMenu()
    }
    func showMenu() {
        UIView.animateWithDuration(1.0, animations: {
            playButton.alpha = 1.0
            highscoreText.alpha = 1.0
        })
    }
}