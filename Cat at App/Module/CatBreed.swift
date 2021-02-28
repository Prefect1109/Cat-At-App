import Foundation

struct Breed : Codable{
    
    let id : String
    let name : String
    let description : String
    
    // Abilities
    let life_span : String
    let intelligence : Int
    let dog_friendly : Int
    let energy_level : Int
    
    let image : BreedImage?
}

struct BreedImage: Codable {
    
    let url : String?
    
}

