import UIKit

class ViewController: UIViewController, ViewConfigurator {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    func addViewHierarchy() {}
    func setupConstraints() {}
    func configureViews() {}
}
