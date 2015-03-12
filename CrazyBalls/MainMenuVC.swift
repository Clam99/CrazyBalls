import Foundation
import UIKit

class MainMenuVC: UIViewController, TargetDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playBut: UIButton!
    @IBOutlet weak var highscoreText: UILabel!
    
    override func viewDidLoad() {
        title.alpha = 0.0
        playBut.alpha = 0.0
        highscoreText.alpha = 0.0
    }
    
    override func loadView() {
        let menu = MainMenu(frame: UIScreen.mainScreen().bounds)
        menu.delegate = self
        self.view = menu
    }
    
    func receiveAction(passedData:String) {
        if (let definiteCase = ButtonLayout(rawValue: passedData)) {
            switch definiteCase {
                case .allHidden:
                    UIView.animateWithDuration(1.5, animations: {
                        title.alpha = 0.0
                        playBut.alpha = 0.0
                        highscoreText.alpha = 0.0
                    })
                case .justTitle:
                    UIView.animateWithDuration(1.5, animations: {
                        title.alpha = 1.0
                        playBut.alpha = 0.0
                        highscoreText.alpha = 0.0
                    })
                case .allShown:
                    UIView.animateWithDuration(1.5, animations: {
                        title.alpha = 1.0
                        playBut.alpha = 1.0
                        highscoreText.alpha = 1.0
                    })
            }
        }
    }
}

enum ButtonLayout: String {
    case allHidden = "Hidden"
    case justTitle = "Only the Title"
    case allShown = "Show all"
}