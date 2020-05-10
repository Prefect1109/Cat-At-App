//
//  ViewController.swift
//  Cat at App
//
//  Created by Богдан Ткачук on 18.04.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - IBotlets
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var catBreedsButton: UIButton!
    @IBOutlet weak var quizButton: UIButton!
    
    //MARK: - Variables
    
    //MARK: - App Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
    }
    
    //MARK: - View
    func configurateView(){
        catBreedsButton.layer.cornerRadius = 10
        quizButton.layer.cornerRadius = 10
    }

    
    @IBAction func playQuizButtonPressed(_ sender: UIButton) {
//        performSegue(withIdentifier: "goToQuizMainView", sender: self)
    }
}

