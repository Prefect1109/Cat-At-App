//
//  CatManager.swift
//  Cat at App
//
//  Created by Богдан Ткачук on 19.04.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import Foundation

protocol CatManagerDelegate{
    func loadImage(with url: URL)
    func openDownloadedImage(withPath: String)
}

class CatManager {
    
    var breedResultData = Data()
    var decodingIsDone = false
    
    var delegate: CatManagerDelegate?
    
    //MARK: - Main Request
    // One for all occasions
    
    func sentRequest(withURl url : String, operation : @escaping (Data) -> String){
        if let url = URL(string: url){
            let request = NSMutableURLRequest(url: url)
            request.setValue(K.apiKey, forHTTPHeaderField: "x-api-key")
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let coderesponce = response as? HTTPURLResponse {
                    print("Code: \(coderesponce.statusCode)")
                    if let safeData = data{
                        DispatchQueue.main.sync {
                            print(operation(safeData))
                        }
                    }
                }
                if error != nil{
                    print(error!)
                }
            }
            task.resume()
        }
        return
    }
    
    //MARK: - Request From VC
    func getCurrentListOfBreeds(){
        sentRequest(withURl: K.AllBreedsMethod, operation: parseCatBreeds)
    }
    
    func getRandomBreedPhoto(){
        // Get random breed id
        
        if K.loadedNextBreedURL{
            delegate?.loadImage(with: URL(string: K.lastImageUrl)!)
            K.loadedNextBreedURL = false
        } else {
            let randomBreedId = Int.random(in: 0...K.breedsList.count - 1)
            K.rightBreedName = K.breedsList[randomBreedId].name
            K.rightBreedId = K.breedsList[randomBreedId].id
            
            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(K.rightBreedId)
            if FileManager.default.fileExists(atPath: path) {
                print("File exist")
                delegate?.openDownloadedImage(withPath: path)
            } else {
                let UrlWithParameters = K.imageSearchMethod + String(K.breedsList[randomBreedId].id)
                self.sentRequest(withURl: UrlWithParameters, operation: parseBreedImage)
            }
            
        }
    }
    
    // boofer for preloading data
    func getNextPhoto(){
        let randomBreedId = Int.random(in: 0...K.breedsList.count - 1)
        K.rightBreedName = K.breedsList[randomBreedId].name
        K.rightBreedId = K.breedsList[randomBreedId].id
        
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(K.rightBreedId)
        
        if !FileManager.default.fileExists(atPath: path) {
            let UrlWithParameters = K.imageSearchMethod + String(K.breedsList[randomBreedId].id)
            self.sentRequest(withURl: UrlWithParameters, operation: self.parseNextBreedImage)
        }
            K.loadedNextBreedURL = false
        // Why don't open new file here? -> Because it's "Boofer" with next photo, so we no needed to open it right now=
        print("File exist When we load next photo")
        
    }
    
    //MARK: - Operation methods (Json Parsing)
    
    // get cat Breeds list
    private func parseCatBreeds(_ data: Data) -> String{
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode([Breed].self, from: data)
            K.breedsList = decodeData
        } catch {
            print("Error with parsing data: \(error)")
            return "Error decoding breed List data"
            
        }
        return "Success decoding breed List data"
    }
    
    // get cat Breed image
    private func parseBreedImage(_ data: Data) -> String {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode([BreedImage].self, from: data)
            for breed in decodeData{
                K.lastImageUrl = breed.url
                print(K.lastImageUrl)
                delegate?.loadImage(with: URL(string: breed.url)!)
            }
        } catch {
            print("Error with parsing data: \(error)")
            return "Error decoding breed image url"
        }
        return "Success decoding breed image url"
    }
    
    private func parseNextBreedImage(_ data: Data) -> String {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode([BreedImage].self, from: data)
            for breed in decodeData{
                K.lastImageUrl = breed.url
                K.loadedNextBreedURL = true
                //                delegate?.loadImage(with: URL(string: breed.url)!)
            }
        } catch {
            print("Error with parsing data: \(error)")
            return "Error decoding breed image url"
        }
        return "Success decoding breed image url"
    }
    
}
