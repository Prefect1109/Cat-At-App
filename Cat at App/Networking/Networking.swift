import Foundation
import UIKit

class Networking {
    
    private init() {}
    
    static let shared = Networking()
    
    var decoder = JSONDecoder()
    
    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    
    //MARK: - Main Request
    
    func loadBreedList() {
        let url = URL(string: APIConstans.AllBreedsURL)!
        let request = NSMutableURLRequest(url: url)
        request.setValue(APIConstans.apiKey, forHTTPHeaderField: "x-api-key")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let coderesponce = response as? HTTPURLResponse {
                print("Code: \(coderesponce.statusCode)")
                if let safeData = data {
                    self.parseCatBreeds(safeData)
                }
            }
            if error != nil{
                print(error!)
            }
        }
        task.resume()
    }
    
    //MARK: - Parsing (Need to refactore)
    
    // Get cat Breeds list
    private func parseCatBreeds(_ data: Data) {
        do {
            let decodeData = try decoder.decode([Breed].self, from: data)
            K.breedsList = decodeData
        } catch {
            print("Error with parsing breed List data: \(error)")
        }
        print("Success decoding breed List data")
    }
    
    //MARK: - Loading Files
    
    func loadImage(breed: Breed, completion: @escaping(Bool, String?) -> Void) {
        
        if breed.image == nil || breed.image!.url == nil || URL(string: breed.image!.url!) == nil{
            completion(false, nil)
            return
        }
        
        let path = self.breedImagePath(breed.id)
        
        if isFileExist(breed.id) {
            completion(true, path)
        }
        
        let url = URL(string: breed.image!.url!)!
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let safeData = data {
                
                let image = UIImage(data: safeData)!.jpegData(compressionQuality: 0.5)
                FileManager.default.createFile(atPath: path, contents: image, attributes: nil)
                completion(true, path)
                return
            }
            
            if error != nil {
                print("Error: \(error!)")
                completion(false, nil)
                return
            }
            
        }.resume()
    }
    
    private func breedImagePath(_ id : String) -> String {
        return "\(documentDirectory)/\(id)"
    }
    
    private func isFileExist(_ fileName: String) -> Bool {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = URL(fileURLWithPath: path)
        
        let filePath = url.appendingPathComponent(fileName).path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            return true
        } else {
            return false
        }
        
    }
}
