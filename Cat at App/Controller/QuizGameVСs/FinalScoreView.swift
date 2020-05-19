//
//  FinalScoreView.swift
//  Cat at App
//
//  Created by Богдан Ткачук on 30.04.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import UIKit

class FinalScoreViewController: UIViewController{
    
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
        K.currentSequenceOfbreeds = K.breedsList.shuffled()
        K.loadIndexNumber = 0
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
        case 100...10000:
            finalText.text = "Are you have self life?\n🤨"
        default:
            finalText.text = "Not Bad\n👌"
        }
    }
    
    @IBAction func mainMenuButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToHomeViewFromFinal", sender: self)
        
    }
    
    @IBAction func playQuizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToQuizViewFromFinal", sender: self)
    }
}
