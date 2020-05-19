//
//  CatBreed.swift
//  Cat at App
//
//  Created by Богдан Ткачук on 18.04.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import Foundation

struct Breed : Codable{
    let id : String
    let name : String
    let description : String
    
    //Abilities
    let life_span : String
    let intelligence : Int
    let dog_friendly : Int
    let energy_level : Int
}

struct BreedImage: Codable {
    let breeds : [Breed]
    let url : String
}

