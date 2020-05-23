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
    static let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    
    // API Methods - API Documentation https://docs.thecatapi.com/authentication
    static let baseUrl = "https://api.thecatapi.com"
    static let AllBreedsMethod = "\(baseUrl)/v1/breeds"
    static let imageSearchMethod = "\(baseUrl)/v1/images/search?breed_ids="
    
    // Run time cache - breeds info
    static var breedsList = [Breed]()
    
    static var catManager = CatManager()
    
    static var rightBreedName = String()
    static var rightBreedId = String()
        
    // Random sequnce of breeds
    static var currentSequenceOfbreeds = [Breed]()
    static var indexNumber = 0
    static var loadIndexNumber = 0
    static var imageNotLoaded = false
    static var needNewUI = false
    
    // Support variables for access control
    static var randomBool = true
    static var loadedNextBreedURL = false
    static var stopDownloadAllPhotos = false

    // Segues Names
    static var finalViewSegueName = "goToFinal"
    static var goToBreedList = "goToBreedList"
    static var goToQuiz = "goToQuiz"
    static var goToQuizMainView = "goToQuizMainView"
    static var goToOneBreedList = "goToOneBreedList"
    
    // Cell Identifier
    static let catBreedCell = "catBreedCell"
    static let catBreedCellClass = "BreedTableViewCell"
}
