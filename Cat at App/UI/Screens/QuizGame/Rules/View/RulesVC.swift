import UIKit

class RulesVC: BaseViewController {
    
    //MARK: - View
    
    @IBOutlet weak var quizTittle: UILabel!
    @IBOutlet weak var rulesView: UIView!
    @IBOutlet weak var twoPlayersButton: UIButton!
    @IBOutlet weak var onePlayerButton: UIButton!
    
    //MARK: - Variables
    
    var showQuiz: (() -> Void)?
    var showCatBreedList: (() -> Void)?
    
    //MARK: - App Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
    }
    
    //MARK: - View
    func configurateView(){
        rulesView.layer.cornerRadius = 15
        twoPlayersButton.layer.cornerRadius = 15
        onePlayerButton.layer.cornerRadius = 15
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onePlayerButtonPressed(_ sender: UIButton) {
        showQuiz?()
    }
    
    @IBAction func breedListButtonPressed(_ sender: UIButton) {
        showCatBreedList?()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if K.breedsList.count == 0 {
            showLowInternetAlert()
        } 
    }
}

