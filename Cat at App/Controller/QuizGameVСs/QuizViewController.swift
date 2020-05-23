//
//  OnePlayerViewController.swift
//  Cat at App
//
//  Created by Богдан Ткачук on 18.04.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import UIKit

class QuizViewController : UIViewController {
    
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
    
    // Spiner outlet
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // Buttons Outlets
    @IBOutlet weak var firtstAnswerButton: UIButton!
    @IBOutlet weak var secondAnswerButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    
    
    //MARK: - Variables
    var timeLeftSeconds : Float = 60
    var stopTimer = false
    var scorePoints = 0
    var heartPoints = 9
    
    
    //MARK: - App Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        K.catManager.delegate = self
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
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
    }
    
    // Actions with button clicks
    @IBAction func firstAnswerButtonPressed(_ sender: UIButton) {
        CheckAnswer(isFirstButton: true)
        newBreedUI()
    }
    
    @IBAction func secondAnswerButtonPressed(_ sender: UIButton) {
        CheckAnswer(isFirstButton: false)
        newBreedUI()
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
                    self.performSegue(withIdentifier: K.finalViewSegueName, sender: nil)
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
    
    
    
    // Answer randomizer
    func randomizeAnswer(){
        let randomBreedNumber = Int.random(in: 0...K.breedsList.count - 1)
        if K.breedsList[randomBreedNumber].name != K.rightBreedName{
            K.randomBool = Bool.random()
            if K.randomBool{
                firtstAnswerButton.setTitle(K.breedsList[randomBreedNumber].name, for: .normal)
                secondAnswerButton.setTitle(K.rightBreedName, for: .normal)
            } else {
                firtstAnswerButton.setTitle(K.rightBreedName, for: .normal)
                secondAnswerButton.setTitle(K.breedsList[randomBreedNumber].name, for: .normal)
            }
            
        } else {
            randomizeAnswer()
            return
        }
    }
    
    func CheckAnswer(isFirstButton : Bool){
        // check what we have - first/second button
        if isFirstButton{
            if !K.randomBool{
                // if randomBool is true we add score point
                // because in randomizeAnswer() if randomBool is true we  adding right answer in first button
                scorePoints += 1
            } else {
                // if randomBool is false we remove heart point
                brokeHeart()
                heartPoints -= 1
            }
            
        } else {
            if K.randomBool{
                scorePoints += 1
            } else {
                brokeHeart()
                heartPoints -= 1
            }
        }
    }
    
    // Sad
    func brokeHeart(){
        switch heartPoints {
        // in start we have 9 lifes
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
            self.performSegue(withIdentifier: K.finalViewSegueName, sender: nil)
        default:
            self.performSegue(withIdentifier: K.finalViewSegueName, sender: nil)
        }
        
    }
    
    // Randomize answers, spinning when loading getting new cat breed image url, and display all in UI
    func newBreedUI(){
        DispatchQueue.main.async {
            self.spinning(shoudSpin: true)
            self.safeClick(isEnable: false)
            K.rightBreedName = K.currentSequenceOfbreeds[K.indexNumber].name
            K.needNewUI = true
            K.catManager.getNextPhoto()
            self.randomizeAnswer()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.finalViewSegueName{
            let destination = segue.destination as! FinalScoreViewController
            print(scorePoints)
            destination.finalScore = scorePoints
        }
    }
    
    // Spinner
    private func spinning(shoudSpin status: Bool) {
        if status{
            spinner.isHidden = false
            spinner.startAnimating()
        } else {
            spinner.isHidden = true
            spinner.stopAnimating()
        }
    }
}



extension QuizViewController : CatManagerDelegate {

    func openDownloadedImage(withPath path: String){
        DispatchQueue.main.async {
            self.catForChoice.image = UIImage(named: path)
            self.spinning(shoudSpin: false)
            self.safeClick(isEnable: true)
        }
    }
}
