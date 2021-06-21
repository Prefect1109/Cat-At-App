import UIKit

class BreedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var catimageView: UIImageView!
    @IBOutlet weak var breedName: UILabel!
    @IBOutlet weak var breedDescription: UILabel!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
        
    var breed : Breed! {
        didSet {
            breedName.text = breed.name
            breedDescription.text = breed.description
            loadImage()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configurateView()
    }
    
    private func configurateView(){
        breedName.layer.cornerRadius = 15
    }
        
    
    //MARK: - Image
    
    private func loadImage(){
        showActivityControl(true)
        
        Networking.shared.loadImage(breed: breed) { (loadStatus, imagePath) in
            DispatchQueue.main.async {
                if loadStatus,
                   let safeImagePath = imagePath {
                    
                    self.showActivityControl(false)
                    self.catimageView.image = UIImage(named: safeImagePath)
                    
                } else {
                    
                    self.showActivityControl(false)
                    self.catimageView.image = UIImage(named: "jpgCat")
                    
                }
            }
        }
    }
    
    // Spinner
    private func showActivityControl(_ isNeedToShow: Bool) {
        if isNeedToShow {
            loader.isHidden = false
            loader.startAnimating()
        } else {
            loader.isHidden = true
            loader.stopAnimating()
        }
    }
}
