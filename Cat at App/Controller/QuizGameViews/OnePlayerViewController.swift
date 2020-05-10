//
//  OnePlayerViewController.swift
//  Cat at App
//
//  Created by Богдан Ткачук on 18.04.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import UIKit

class OnePlayerViewController : UIViewController {
    
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
    var timeLeftSeconds = 60
    var stopTimer = false
    var scorePoints = 0
    var heartPoints = 9
    
    
    //MARK: - App Cycle methods
    override func loadView() {
        super.loadView()
        newBreedUI()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        K.catManager.delegate = self
        configurateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        startTimer()
    }
    
    
    //View
    func configurateView(){
        firtstAnswerButton.layer.cornerRadius = 15
        secondAnswerButton.layer.cornerRadius = 15
        skipButton.layer.cornerRadius = 15
    }
    
    // Go back from this screen
    @IBAction func backButtonPressed(_ sender: UIButton) {
        // add UIAlert
        stopTimer = true
        let alert = UIAlertController(title: "Warning", message: "you will lose your progress", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play", style: .cancel, handler: { (cancelAlert) in
            self.stopTimer = false
            self.startTimer()
        }))
        alert.addAction(UIAlertAction(title: "Exit", style: .default, handler: { (Exitalert) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
    }
    
    // Spinner
    func spinning(shoudSpin status: Bool) {
        if status{
            spinner.isHidden = false
//            self.stopTimer = true
            spinner.startAnimating()
        } else {
            spinner.isHidden = true
//            self.stopTimer = false
//            startTimer()
            spinner.stopAnimating()
        }
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
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            if !(self.stopTimer){
                self.timeLeftSeconds -= 1
            }
            
            self.timeLeft.text = String(self.timeLeftSeconds)
            print(self.timeLeftSeconds)
            
            if (self.timeLeftSeconds==0) || (self.stopTimer){
                timer.invalidate()
                self.performSegue(withIdentifier: K.finalViewSegueName, sender: nil)
            }
        }
    }
    
    // Answer randomizer
    func randomizeAnswer(){
        K.randomBool = Bool.random()
        if K.randomBool{
            firtstAnswerButton.setTitle(K.breedsList[Int.random(in: 0...K.breedsList.count - 1)].name, for: .normal)
            secondAnswerButton.setTitle(K.rightBreedName, for: .normal)
        } else {
            firtstAnswerButton.setTitle(K.rightBreedName, for: .normal)
            secondAnswerButton.setTitle(K.breedsList[Int.random(in: 0...K.breedsList.count - 1)].name, for: .normal)
        }
    }
    
    func CheckAnswer(isFirstButton : Bool){
        // check what we have - first/second button
        if isFirstButton{
            if K.randomBool{
                // if randomBool is true we add score point
                // because in randomizeAnswer() if randomBool is true we  adding right answer in first button
                scorePoints += 1
            } else {
                // if randomBool is false we remove heart point
                brokeHeart()
                heartPoints -= 1
            }
            
        } else {
            if !K.randomBool{
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
        spinning(shoudSpin: true)
        K.catManager.getRandomBreedPhoto()
        randomizeAnswer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.finalViewSegueName{
            let destination = segue.destination as! FinalScoreViewController
            print(scorePoints)
            destination.finalScore = scorePoints
        }
    }
    private func saveImage(image image: UIImage, breedId id : String){
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String)
        print(path)
//        if !fileManager.fileExists(atPath: path) {
//        try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
//        }
        let url = URL(string: path)
        let imagePath = url!.appendingPathComponent(id)
        let urlString: String = imagePath.absoluteString
        let imageData = image.jpegData(compressionQuality: 0.5)
        //let imageData = UIImagePNGRepresentation(image)
        fileManager.createFile(atPath: urlString as String, contents: imageData, attributes: nil)
    }
}



extension OnePlayerViewController : CatManagerDelegate {
    func loadImage(with url: URL) {
        K.loadedNextBreedURL = false
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if error != nil{
                print("Error: \(error!)")
                return
            }
            if let safeData = data {
                DispatchQueue.main.async {
                    self.catForChoice.image = UIImage(data: safeData)
                    self.saveImage(image: self.catForChoice.image!, breedId: K.rightBreedId)
                    self.spinning(shoudSpin: false)
                    
                    K.catManager.getNextPhoto()
                }

            }

        }.resume()
    }
    func openDownloadedImage(withId: String){
        
    }
}
