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
    @IBOutlet weak var breedName: UILabel!
    @IBOutlet weak var breedImage: UIImageView!
    
    //Abilities IBotlets
    @IBOutlet weak var lifeSpan: UILabel!
    @IBOutlet weak var intelligence: UILabel!
    @IBOutlet weak var dogFriendly: UILabel!
    @IBOutlet weak var energyLevel: UILabel!    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var breedDescription: UILabel!
    
    //MARK: - Variables
    var breed = K.breedsList[0]
    
    //MARK: - App Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        K.catManager.delegate = self
        addImage()
        configurateView()
        
    }
    
    //    override func viewWillDisappear(_ animated: Bool) {
    //        K.stopDownloadAllPhotos = false
    //        K.catManager.loadAllBreedsPhotos()
    //    }
    
    //MARK: - View
    private func configurateView(){
        spinning(shoudSpin: true)
        updateText()
    }
    
    private func addImage(){
        DispatchQueue.main.async {
            K.catManager.getBreedInformation(id: self.breed.id)
        }
    }
    
    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func saveImage(with image: UIImage, breedId id : String){
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String)
        print(path)
        let url = URL(string: path)
        let imagePath = url!.appendingPathComponent(id)
        let urlString: String = imagePath.absoluteString
        let imageData = image.jpegData(compressionQuality: 0.5)
        fileManager.createFile(atPath: urlString as String, contents: imageData, attributes: nil)
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
    private func updateText(){
        breedName.text = breed.name
        breedDescription.text = breed.description
        lifeSpan.text = breed.life_span
        intelligence.text = "\(breed.intelligence) / 5"
        dogFriendly.text = "\(breed.dog_friendly) / 5"
        energyLevel.text = "\(breed.energy_level ) / 10"
    }
}

extension BreedDescriptionViewController : CatManagerDelegate {
    func loadImage(with url: URL) {
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if error != nil{
                print("Error: \(error!)")
                return
            }
            if let safeData = data {
                DispatchQueue.main.async {
                    self.breedImage.image = UIImage(data: safeData)
                    self.saveImage(with: self.breedImage.image!, breedId: self.breed.id)
                    self.spinning(shoudSpin: false)
                }
                
            }
            
        }.resume()
        
        K.catManager.loadAllBreedsPhotos(interval: 0.15)
    }
    func openDownloadedImage(withPath path: String){
        
        DispatchQueue.main.async {
            self.breedImage.image = UIImage(named: path)
            self.spinning(shoudSpin: false)
        }
        K.catManager.loadAllBreedsPhotos(interval: 0.15)
    }
}
