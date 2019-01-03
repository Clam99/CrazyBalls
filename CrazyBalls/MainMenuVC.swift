import Foundation
import UIKit

class MainMenuVC: UIViewController, TargetDelegate {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var playBut: UIButton!
    @IBOutlet var highscoreText: UILabel!
    
    override func viewDidLoad() {
        if let label = titleLabel {
            label.alpha = 0.0
        }
        if let but = playBut {
            but.alpha = 0.0
        }
        if let label = highscoreText {
            label.alpha = 0.0
        }
    }
    /*
    override func loadView() {
        let menu = MainMenu(frame: UIScreen.mainScreen().bounds)
        menu.delegate = self
        self.view = menu
    }*/
    
    func receiveAction(_ passedData:String) {
        if let definiteCase = ButtonLayout(rawValue: passedData) {
            switch definiteCase {
                case .allHidden:
                    UIView.animate(withDuration: 1.5, animations: {
                        self.titleLabel.alpha = 0.0
                        self.playBut.alpha = 0.0
                        self.highscoreText.alpha = 0.0
                    })
                case .justTitle:
                    UIView.animate(withDuration: 1.5, animations: {
                        self.titleLabel.alpha = 1.0
                        self.playBut.alpha = 0.0
                        self.highscoreText.alpha = 0.0
                    })
                case .allShown:
                    UIView.animate(withDuration: 1.5, animations: {
                        self.titleLabel.alpha = 1.0
                        self.playBut.alpha = 1.0
                        self.highscoreText.alpha = 1.0
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
