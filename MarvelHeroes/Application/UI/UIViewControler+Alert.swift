import UIKit
extension UIViewController {
    func showSimpleAlert(title: String?, text: String?, cancelButtonTitle: String) {
        let alert : UIAlertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let action : UIAlertAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
