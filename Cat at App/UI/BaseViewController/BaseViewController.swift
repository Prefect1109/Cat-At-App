import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - View
    
    let activityControl = UIActivityIndicatorView()
    
   //MARK: - VC cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        configurateUI()
    }
    
    //MARK: - Configurate UI
    
    func configurateUI() {
        
        // Setup activity control
        activityControl.style = .large
        activityControl.color = .white
        
        layoutActivityControl()
        
    }
    
    func layoutActivityControl() {
        
        view.addSubview(activityControl)
        activityControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    //MARK: - UIActivityIndicatorView
    
    func showActivityControl(_ isNeedToShow: Bool) {
        
        DispatchQueue.main.async {
            if isNeedToShow {
                self.activityControl.isHidden = false
                self.activityControl.startAnimating()
            } else {
                self.activityControl.isHidden = true
                self.activityControl.stopAnimating()
            }
        }
        
    }
    
    //MARK: - Alerts
    
    func showAlert(title: String, message: String, firstAlertString: String, secondAlertString: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: firstAlertString, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: secondAlertString, style: .default, handler: { (_) in
            let settingsUrl = URL(string: UIApplication.openSettingsURLString)
            if let url = settingsUrl {
                UIApplication.shared.openURL(url)
            }
        }))
        present(alert, animated: true)
    }
    
    // Low internet alert
    func showLowInternetAlert(){
        showAlert(title: "We load new breeds",
                  message: "Your internet connection is unreachable, or low\n if low wait few seconds and try again.",
                  firstAlertString: "👌🏻 Try Again",
                  secondAlertString: "🛠 Settings")
    }
    
}
