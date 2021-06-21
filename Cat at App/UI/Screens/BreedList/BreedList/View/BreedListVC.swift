import UIKit

class BreedListVC : BaseViewController {
        
    //MARK: - View
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
        
    var showCatBreedList: ((Int) -> Void)?
        
    //MARK: - App Cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(R.nib.breedTableViewCell)
        
        configurateView()
    }
    
    //MARK: - View
    
    private func configurateView(){
        tableView.separatorStyle = .none
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - UITableViewDelegate && UITableViewDataSource

extension BreedListVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.breedsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.breedTableViewCell.identifier, for: indexPath) as! BreedTableViewCell
        cell.breed = K.breedsList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showCatBreedList?(indexPath.row)
    }
}
