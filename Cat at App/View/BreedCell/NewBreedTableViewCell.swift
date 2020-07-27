//
//  NewBreedTableViewCell.swift
//  Cat at App
//
//  Created by Богдан Ткачук on 05.06.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import UIKit

class NewBreedTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var catimageView: UIImageView!
    @IBOutlet weak var breedName: UILabel!
    @IBOutlet weak var breedDescription: UILabel!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var breed = K.breedsList[0]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        K.catManager.delegate = self
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configurateView()
        addImage()
        // Configure the view for the selected state
    }
    
    private func configurateView(){
        breedName.layer.cornerRadius = 15
        spinning(shoudSpin: true)
    }
    
    // Spinner
    private func spinning(shoudSpin status: Bool) {
        if status{
            loader.isHidden = false
            loader.startAnimating()
        } else {
            loader.isHidden = true
            loader.stopAnimating()
        }
    }
    
    //MARK: - add image
    private func addImage(){
        DispatchQueue.main.async {
            K.catManager.getBreedInformation(id: self.breed.id)
        }
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
    
}

extension NewBreedTableViewCell : CatManagerDelegate {
    func loadImage(with url: URL) {
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if error != nil{
                print("Error: \(error!)")
                return
            }
            if let safeData = data {
                DispatchQueue.main.async {
                    self.catimageView.image = UIImage(data: safeData)
                    self.saveImage(with: self.catimageView.image!, breedId: self.breed.id)
                    self.spinning(shoudSpin: false)
                }
                
            }
            
        }.resume()
        
        K.catManager.loadAllBreedsPhotos(interval: 0.15)
    }
    func openDownloadedImage(withPath path: String){
        
        DispatchQueue.main.async {
            self.catimageView.image = UIImage(named: path)
            self.spinning(shoudSpin: false)
        }
        K.catManager.loadAllBreedsPhotos(interval: 0.15)
    }
}

