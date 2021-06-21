import UIKit

class QuizVC : BaseViewController {
    
    // Lifes images otlets
    @IBOutlet weak var life1: UIImageView!
    @IBOutlet weak var life2: UIImageView!
    @IBOutlet weak var life3: UIImageView!
    @IBOutlet weak var life4: UIImageView!
    @IBOutlet weak var life5: UIImageView!
    @IBOutlet weak var life6: UIImageView!
    @IBOutlet weak var life7: UIImageView!
    @IBOutlet weak var life8: UIImageView!
    @IBOutlet weak var life9: UIImageView!
    
    // Display gow much time is remaning
    @IBOutlet weak var timeLeft: UILabel!
    
    // CatImage
    @IBOutlet weak var catForChoice: UIImageView!
    
    // Buttons Outlets
    @IBOutlet weak var firtstAnswerButton: UIButton!
    @IBOutlet weak var secondAnswerButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    //MARK: - Variables
    
    var showFinal: (() -> Void)?
    
    var timeLeftSeconds : Float = 60
    var stopTimer = false
    
    // Lives
    var scorePoints = 0
    var heartPoints = 9
    
    // Breed
    var randomisedBreedArray = K.breedsList.shuffled()
    var currentRightIndex = -1
    
    var randomBool = Bool()
    
    //MARK: - App Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
        newBreedUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        startTimer()
    }
    
    
    //MARK: - View configuration
    private func configurateView(){
        
        firtstAnswerButton.layer.cornerRadius = 15
        secondAnswerButton.layer.cornerRadius = 15
        skipButton.layer.cornerRadius = 15
        
    }
    
    //MARK: - IBActions
    
    // Go back from this screen
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        // add UIAlert
        stopTimer = true
        let alert = UIAlertController(title: "Warning", message: "You will lose your progress", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play", style: .cancel, handler: { (_) in
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
                self.stopTimer = false
                self.startTimer()
            }
        }))
        alert.addAction(UIAlertAction(title: "Exit", style: .default, handler: { (_) in
            self.timeLeftSeconds = 0
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    // Actions with button clicks
    @IBAction func firstAnswerButtonPressed(_ sender: UIButton) {
        CheckAnswer(isFirstButton: true)
    }
    
    @IBAction func secondAnswerButtonPressed(_ sender: UIButton) {
        CheckAnswer(isFirstButton: false)
    }
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        newBreedUI()
    }
    
    // TIMER
    func startTimer(){
        Timer.scheduledTimer(withTimeInterval: 0.0001, repeats: true) { timer in
            
            if self.stopTimer {
                self.stopTimer = false
                timer.invalidate()
            } else {
                self.timeLeftSeconds -= 0.0001
                self.timeLeft.text = String(Int(self.timeLeftSeconds))
                if (Int(self.timeLeftSeconds) <= 0){
                    timer.invalidate()
//                    self.performSegue(withIdentifier: Segue.finalViewSegueName, sender: nil)
                }
            }
        }
    }
    
    //MARK: - Support Methods
    func safeClick(isEnable: Bool){
        
        if isEnable{
            firtstAnswerButton.isEnabled = true
            secondAnswerButton.isEnabled = true
            skipButton.isEnabled = true
        } else {
            firtstAnswerButton.isEnabled = false
            secondAnswerButton.isEnabled = false
            skipButton.isEnabled = false
        }
    }
    
    
    
    // Answer randomised
    func randomizeAnswer(){
        let randomisedIndex = Int.random(in: 0...randomisedBreedArray.count - 1)
        let randomisedName = randomisedBreedArray[randomisedIndex].name
        
        let currentRightBreedName = randomisedBreedArray[currentRightIndex].name
        
        if randomisedName != currentRightBreedName {
            
            randomBool = Bool.random()
            
            if randomBool {
                firtstAnswerButton.setTitle(randomisedName, for: .normal)
                secondAnswerButton.setTitle(currentRightBreedName, for: .normal)
            } else {
                firtstAnswerButton.setTitle(randomisedName, for: .normal)
                secondAnswerButton.setTitle(currentRightBreedName, for: .normal)
            }
            
        } else {
            randomizeAnswer()
            return
        }
    }
    
    func CheckAnswer(isFirstButton: Bool) {
        
        // check what we have - first/second button
        if isFirstButton {
            if !randomBool {
                // if randomBool is true we add score point
                // because in randomizeAnswer() if randomBool is true we  adding right answer in first button
                scorePoints += 1
            } else {
                // if randomBool is false we remove heart point
                brokeHeart()
                heartPoints -= 1
            }
            
        } else {
            if randomBool{
                scorePoints += 1
            } else {
                brokeHeart()
                heartPoints -= 1
            }
        }
        
        newBreedUI()
    }
    
    // Sad
    func brokeHeart(){
        switch heartPoints {
        // in start we have 9 lives
        case 9:
            life9.image = UIImage(named: "brokeHeart")
        case 8:
            life8.image = UIImage(named: "brokeHeart")
        case 7:
            life7.image = UIImage(named: "brokeHeart")
        case 6:
            life6.image = UIImage(named: "brokeHeart")
        case 5:
            life5.image = UIImage(named: "brokeHeart")
        case 4:
            life4.image = UIImage(named: "brokeHeart")
        case 3:
            life3.image = UIImage(named: "brokeHeart")
        case 2:
            life2.image = UIImage(named: "brokeHeart")
        case 1:
            life1.image = UIImage(named: "brokeHeart")
            self.stopTimer = true
//            self.performSegue(withIdentifier: Segue.finalViewSegueName, sender: nil)
        default:
            print(123)
//            self.performSegue(withIdentifier: Segue.finalViewSegueName, sender: nil)
        }
        
    }
    
    // Randomise answers, spinning when loading getting new cat breed image url, and display all in UI
    func newBreedUI(){
        
        DispatchQueue.main.async {
            self.showActivityControl(true)
            self.safeClick(isEnable: false)
            self.currentRightIndex += 1
            
            Networking.shared.loadImage(breed: self.randomisedBreedArray[self.currentRightIndex]) { (loadStatus, imagePath) in
                DispatchQueue.main.async {
                    if loadStatus,
                       let safeImagePath = imagePath {
                        
                        self.showActivityControl(false)
                        self.safeClick(isEnable: true)
                        self.catForChoice.image = UIImage(named: safeImagePath)
                        
                    } else {
                        
                        // If you here something going wrong with api url, probably
                        self.showActivityControl(false)
                        self.newBreedUI()
                        
                    }
                }
            }
            
            self.randomizeAnswer()
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == Segue.finalViewSegueName{
//            let destination = segue.destination as! FinalScoreVC
//            destination.finalScore = scorePoints
//        }
//    }
}
