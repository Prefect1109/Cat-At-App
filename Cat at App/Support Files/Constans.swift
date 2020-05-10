//
//  Constans.swift
//  Cat at App
//
//  Created by Богдан Ткачук on 18.04.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import Foundation

struct K {
    static let apiKey = "8733fa87-4e44-4d33-af10-72d93e949cb9"
    
    // API Methods - API Documentation https://docs.thecatapi.com/authentication
    static let baseUrl = "https://api.thecatapi.com"
    static let AllBreedsMethod = "\(baseUrl)/v1/breeds"
    static let imageSearchMethod = "\(baseUrl)/v1/images/search?breed_ids="
    
    // Run time cache - breeds info
    static var breedsList = [Breed]()
    static var catManager = CatManager()
    static var lastImageUrl = String() 
    static var rightBreedName = String()
    static var rightBreedId = String()
    
    // Support variables for access control
    static var randomBool = true
    static var loadedNextBreedURL = false

    // Segues Names
    static var finalViewSegueName = "goToFinal"
    
    // Cell Identifier
    static let catBreedCell = "catBreedCell"
    static let catBreedCellClass = "BreedTableViewCell"
}
