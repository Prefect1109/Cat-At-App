//
//  BreedDescriptionViewController.swift
//  Cat at App
//
//  Created by Богдан Ткачук on 10.05.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//
import UIKit

class BreedDescriptionViewController: UIViewController {
    
    
    //MARK: - IBotlets
    
    //MARK: - Variables
    
    //MARK: - App Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
    }
    
    //MARK: - View
    private func configurateView(){
    }
    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
