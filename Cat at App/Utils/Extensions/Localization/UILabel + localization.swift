import UIKit

public extension UILabel {

    @IBInspectable var localizedText: String? {
        get {
            return text
        }
        set {
            text = NSLocalizedString(newValue ?? "", comment: "")
        }
    }

}
