//
//  OnePlayerViewController.swift
//  Cat at App
//
//  Created by Богдан Ткачук on 18.04.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import UIKit

class BreedListViewController : UIViewController {
    
    
    //MARK: - IBotlets
    @IBOutlet weak var tableView: UITableView!
    //MARK: - Variables
    
    //MARK: - App Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.catBreedCellClass, bundle: nil), forCellReuseIdentifier: K.catBreedCell)
        configurateView()
        
    }
    
    //MARK: - View
    private func configurateView(){
        tableView.separatorStyle = .none
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! BreedDescriptionViewController
    }
}


extension BreedListViewController : UITableViewDelegate, UITableViewDataSource{
    
    // UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.breedsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.catBreedCell, for: indexPath) as! BreedTableViewCell
        cell.breedName.text = K.breedsList[indexPath.row].name
        cell.breedDescription.text = K.breedsList[indexPath.row].description
        cell.lifeSpan.text = K.breedsList[indexPath.row].life_span
        cell.intelligence.text = "\(K.breedsList[indexPath.row].intelligence) / 5"
        cell.dogFriendly.text = "\(K.breedsList[indexPath.row].dog_friendly) / 5"
        cell.energyLevel.text = "\(K.breedsList[indexPath.row].energy_level ) / 10"
        return cell
    }
    
    // UITableViewDelegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToBreedDescription", sender: self)
    }
    
    
}
