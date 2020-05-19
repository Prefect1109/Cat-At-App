//
//  CatManager.swift
//  Cat at App
//
//  Created by Богдан Ткачук on 19.04.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import Foundation
import UIKit

protocol CatManagerDelegate{
    func loadImage(with url: URL)
    func openDownloadedImage(withPath: String)
}

class CatManager {
    
    var breedResultData = Data()
    var decodingIsDone = false
    
    var delegate: CatManagerDelegate?
    
    //MARK: - Main Request
    func sentRequest(breedId : String, withURl url : String, operation : @escaping (Data, String) -> String){
        if let url = URL(string: url){
            let request = NSMutableURLRequest(url: url)
            request.setValue(K.apiKey, forHTTPHeaderField: "x-api-key")
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let coderesponce = response as? HTTPURLResponse {
                    print("Code: \(coderesponce.statusCode)")
                    if let safeData = data{
                        DispatchQueue.main.sync {
                            print(operation(safeData, breedId))
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
        sentRequest(breedId: "Null", withURl: K.AllBreedsMethod, operation: parseCatBreeds)
    }
    
    func getNextPhoto(){
        
        // If we clicked on breeds more than cout of it's
        if K.currentSequenceOfbreeds.count == K.indexNumber + 1{
            K.currentSequenceOfbreeds = K.breedsList.shuffled()
            K.indexNumber = 0
        }
        
        let breed = K.currentSequenceOfbreeds[K.indexNumber]
        
        let path = K.documentDirectory.appendingPathComponent(breed.id)
        
        if FileManager.default.fileExists(atPath: path){
            if K.needNewUI{
                delegate?.openDownloadedImage(withPath: path)
                K.indexNumber += 1
                K.imageNotLoaded = false
                K.needNewUI = false
            }
        } else {
            K.imageNotLoaded = true
        }
    }
    
    private func loadAllBreedsPhotos(){
        if K.currentSequenceOfbreeds.count == K.loadIndexNumber{
            K.loadIndexNumber = 0
            return
        }
        
        let breed = K.currentSequenceOfbreeds[K.loadIndexNumber]
        let path = breedImagePath(breed.id)
        
        if !FileManager.default.fileExists(atPath: path){
            let UrlWithParameters = K.imageSearchMethod + breed.id
            DispatchQueue.main.async {
                self.sentRequest(breedId: breed.id, withURl: UrlWithParameters, operation: self.parseBreedImage)
            }
        }
        
        K.loadIndexNumber += 1
    }
    
    //MARK: - Request from Breed Description VC
    func getBreedInformation(id : String){
        // Get preloadedData or existFile
        let path = breedImagePath(id)
        if FileManager.default.fileExists(atPath: path) {
            print("File exist")
            delegate?.openDownloadedImage(withPath: path)
        } else {
            let UrlWithParameters = K.imageSearchMethod + id
            self.sentRequest(breedId: id, withURl: UrlWithParameters, operation: parseBreedImage)
        }
        
    }
    
    //MARK: - Operation methods (Json Parsing)
    
    // get cat Breeds list
    private func parseCatBreeds(_ data: Data, _ breedId: String) -> String{
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode([Breed].self, from: data)
            K.breedsList = decodeData
            K.currentSequenceOfbreeds = K.breedsList.shuffled()
            DispatchQueue.main.async {
                self.loadAllBreedsPhotos()
            }
        } catch {
            print("Error with parsing data: \(error)")
            return "Error decoding breed List data"
            
        }
        return "Success decoding breed List data"
    }
    
    // get cat Breed image
    private func parseBreedImage(_ data: Data, _ breedId: String) -> String {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode([BreedImage].self, from: data)
            for breed in decodeData{
                DispatchQueue.main.async {
                    self.loadImage(with: URL(string: breed.url)!, breedId)
                }
            }
        } catch {
            print("Error with parsing data: \(error)")
            return "Error decoding breed image url"
        }
        return "Success decoding breed image url"
    }
    
    //MARK: - Loading Files
    private func loadImage(with url: URL, _ breedId: String) {
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            
            if let safeData = data {
                
                let path = self.breedImagePath(breedId)
                let image = UIImage(data: safeData)!.jpegData(compressionQuality: 0.5)
                
                FileManager.default.createFile(atPath: path, contents: image, attributes: nil)
                
                print(path)
                
                DispatchQueue.main.async {
                    self.loadAllBreedsPhotos()
                }
                
                if K.imageNotLoaded{
                    self.getNextPhoto()
                }
                
                
            }
            
            if error != nil{
                print("Error: \(error!)")
                return
            }
            
        }.resume()
    }
    
    private func breedImagePath(_ id : String) -> String {
        return K.documentDirectory.appendingPathComponent(id)
    }
}
