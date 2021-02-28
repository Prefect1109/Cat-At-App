import UIKit

class FinalScoreVC: BaseViewController {
    
    // Butonns outlets
    @IBOutlet weak var mainMenuButton: UIButton!
    @IBOutlet weak var playQuizButton: UIButton!
    
    // Final Stat outlet
    @IBOutlet weak var finalStatText: UILabel!
    
    // final stats description
    @IBOutlet weak var finalText: UILabel!
    
    //MARK: - Variables
    var finalScore = 0
    
    //MARK: - App Cycle methods
    override func loadView() {
        super.loadView()
        finalStatText.text = String(finalScore)
        configurateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // configurateView
    func configurateView(){
        mainMenuButton.layer.cornerRadius = 10
        playQuizButton.layer.cornerRadius = 10
        textForCurrentScore()
    }
    
    private func textForCurrentScore(){
        switch finalScore {
        case 0:
            finalText.text = "You even see cats?\n😐"
        case 1...5:
            finalText.text = "Try again, you could better\n😸"
        case 6...9:
            finalText.text = "It's not your limit\n👀"
        case 10...15:
            finalText.text = "A little more and you can be an expert\n😎"
        case 16...99:
            finalText.text = "Awesome, you expert in fluffies\n🤓"
        default:
            finalText.text = "Are you have self life?\n🤨"
        }
    }
    
    @IBAction func mainMenuButtonPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func playQuizButton(_ sender: UIButton) {
        let controllers = self.navigationController?.viewControllers
        for vc in controllers! {
            if vc is RulesVC {
                _ = self.navigationController?.popToViewController(vc as! RulesVC, animated: true)
            }
        }
    }
}
