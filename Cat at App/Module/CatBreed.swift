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
}

struct BreedImage: Codable {
//    let breeds : Breed
    let url : String
}

