import UIKit

class BreedListVC : BaseViewController {
        
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    var lastSelectedIndexPath : IndexPath!
        
    //MARK: - App Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CellID.catBreedCellClass, bundle: nil), forCellReuseIdentifier: CellID.catBreedCell)
        
        configurateView()
    }
    
    //MARK: - View
    private func configurateView(){
        tableView.separatorStyle = .none
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! BreedDescriptionVC
        destination.breed = K.breedsList[lastSelectedIndexPath.row]
    }
}

//MARK: - UITableViewDelegate && UITableViewDataSource

extension BreedListVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.breedsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.catBreedCell, for: indexPath) as! BreedTableViewCell
        cell.breed = K.breedsList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastSelectedIndexPath = indexPath
        performSegue(withIdentifier: "goToBreedDescription", sender: self)
    }
}
