import UIKit

protocol Router: AnyObject {
    var rootViewController: UIViewController? { get set }
    func goBack()
    func dismiss()
}

extension Router {
    func goBack() {
        rootViewController?.navigationController?.popViewController(animated: true)
    }
    
    func dismiss() {
        rootViewController?.dismiss(animated: true, completion: nil)
        rootViewController = nil
    }
}
