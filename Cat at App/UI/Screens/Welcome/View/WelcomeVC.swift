import UIKit

class WelcomeVC: BaseViewController {
    
    //MARK: - View
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var catBreedsButton: UIButton!
    @IBOutlet weak var quizButton: UIButton!
    
    //MARK: - Variables
    
    var showCatBreedList: (() -> Void)?
    var showRules: (() -> Void)?
    
    //MARK: - App Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
        loadBreedList()
    }
    
    //MARK: - View
    func configurateView(){
        catBreedsButton.layer.cornerRadius = 10
        quizButton.layer.cornerRadius = 10
    }
    
    private func loadBreedList() {
        Networking.shared.loadBreedList()
    }
    
    //MARK: - Actions
    
    @IBAction func getCatBreedsList(_ sender: UIButton) {
//        if K.breedsList.count == 0 {
//            showLowInternetAlert()
//        } else {
//            performSegue(withIdentifier: Segue.goToBreedList, sender: self)
//        }
        showCatBreedList?()
    }
    
    @IBAction func goToCatQuizRules(_ sender: UIButton) {
//        performSegue(withIdentifier: Segue.goToQuizMainView, sender: self)
        showRules?()
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.goToBreedList {
            _ = segue.destination as! BreedListVC
        } else if segue.identifier == Segue.goToQuizMainView{
            _ = segue.destination as! RulesVC
        }
    }
}
