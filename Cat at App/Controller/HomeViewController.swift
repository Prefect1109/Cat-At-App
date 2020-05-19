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
    
    @IBAction func getCatBreedsList(_ sender: UIButton) {
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
            performSegue(withIdentifier: K.goToBreedList, sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.goToBreedList {
            _ = segue.destination as! BreedListViewController
        }
    }
}
