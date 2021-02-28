import UIKit

class BreedDescriptionVC: BaseViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var breedName: UILabel!
    @IBOutlet weak var breedImage: UIImageView!
    
    // Abilities
    @IBOutlet weak var lifeSpan: UILabel!
    @IBOutlet weak var intelligence: UILabel!
    @IBOutlet weak var dogFriendly: UILabel!
    @IBOutlet weak var energyLevel: UILabel!    
    @IBOutlet weak var breedDescription: UILabel!
    
    //MARK: - Variables
    
    var breed : Breed!
    
    //MARK: - App Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
        updateText()
    }
    
    func updateText() {
        breedName.text = breed.name
        breedDescription.text = breed.description
        lifeSpan.text = breed.life_span
        intelligence.text = "\(breed.intelligence) / 5"
        dogFriendly.text = "\(breed.dog_friendly) / 5"
        energyLevel.text = "\(breed.energy_level ) / 10"
    }
    
    override func layoutActivityControl() {
        
        // Setup activityControl
        breedImage.addSubview(activityControl)
        activityControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityControl.centerYAnchor.constraint(equalTo: breedImage.centerYAnchor),
            activityControl.centerXAnchor.constraint(equalTo: breedImage.centerXAnchor)
        ])
        
    }
    
    //MARK: - View
    
    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Load image
    
    private func loadImage(){
        self.showActivityControl(true)
        Networking.shared.loadImage(breed: breed) { (loadStatus, imagePath) in
            DispatchQueue.main.async {
                if loadStatus,
                   let safeImagePath = imagePath {
                    
                    self.showActivityControl(false)
                    self.breedImage.image = UIImage(named: safeImagePath)
                    
                } else {
                    
                    self.showActivityControl(false)
                    self.breedImage.image = UIImage(named: "jpgCat")
                    
                }
            }
        }
    }
}
