//
//  QuizHomeViewController.swift
//  Cat at App
//
//  Created by Богдан Ткачук on 18.04.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import UIKit

class RulesViewController: UIViewController{
    
    //MARK: - IBotlets
    @IBOutlet weak var quizTittle: UILabel!
    @IBOutlet weak var rulesView: UIView!
    @IBOutlet weak var twoPlayersButton: UIButton!
    @IBOutlet weak var onePlayerButton: UIButton!
    
    //MARK: - Variables
    
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
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onePlayerButtonPressed(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if K.breedsList.count == 0{
            let alert = UIAlertController(title: "Need inernet connection", message: "Your internet connection is unreachable, or low\n if low wait few seconds and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "👌🏻 Try Again", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "🛠 Settings", style: .default, handler: { (_) in
                let settingsUrl = URL(string: UIApplication.openSettingsURLString)
                if let url = settingsUrl {
                    UIApplication.shared.openURL(url)
                }
            }))
            present(alert, animated: true)
        } else {
            K.indexNumber = 0
        }
    }
}

