//
//  BreedTableViewCell.swift
//  Cat at App
//
//  Created by Богдан Ткачук on 10.05.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import UIKit

class BreedTableViewCell: UITableViewCell {

    @IBOutlet weak var breedName: UILabel!
    @IBOutlet weak var breedDescription: UILabel!
    // Abilities
    @IBOutlet weak var lifeSpan: UILabel!
    @IBOutlet weak var intelligence: UILabel!
    @IBOutlet weak var dogFriendly: UILabel!
    @IBOutlet weak var energyLevel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
