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
    }
    
    // configurateView
    func configurateView(){
        mainMenuButton.layer.cornerRadius = 10
        playQuizButton.layer.cornerRadius = 10
    }
    
    @IBAction func mainMenuButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToHomeViewFromFinal", sender: self)
        
    }
    
    @IBAction func playQuizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goToQuizViewFromFinal", sender: self)
    }
}
