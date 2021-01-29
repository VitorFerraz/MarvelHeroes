import UIKit

final class HomeRouter: Router {
    var rootViewController: UIViewController?
    
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    class func viewController(repository: CharacterRepository) -> UIViewController {
        let viewController = HomeViewController()
        viewController.view.backgroundColor = .red
        let router  = HomeRouter(rootViewController: viewController)
        let interactor  = HomeInteractor()
        let presenter  = HomePresenter(interactor, router)
        
        viewController.presenter = presenter
        viewController.tabBarItem = .init(title: "Hereos", image: nil, tag: 0)
//        viewController.tabBarItem.selectedImage = nil.withRenderingMode(.alwaysOriginal)
        let rootViewController : UINavigationController = UINavigationController(rootViewController: viewController)
        
        return rootViewController
    }
}
