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
        viewController.tabBarItem = UITabBarItem(title: "Hereos", image: #imageLiteral(resourceName: "icon-iron-man-unselected"), tag: 0)
        viewController.tabBarItem.selectedImage = #imageLiteral(resourceName: "icon-iron-man").withRenderingMode(.alwaysOriginal)
        viewController.title = ""
        let rootViewController : UINavigationController = UINavigationController(rootViewController: viewController)
        
        return rootViewController
    }
}
