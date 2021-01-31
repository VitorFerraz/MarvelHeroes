import UIKit

final class HomeRouter: Router {
    var rootViewController: UIViewController?
    
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    class func viewController(repository: CharacterRepository) -> UIViewController {
        let viewController = HomeViewController()
        let router  = HomeRouter(rootViewController: viewController)
        let interactor  = HomeInteractor()
        let presenter  = HomePresenter(interactor, router)
        interactor.output = presenter
        presenter.view = viewController
        viewController.presenter = presenter
        viewController.tabBarItem = UITabBarItem(title: NSLocalizedString("Hereos",comment: ""), image: #imageLiteral(resourceName: "icon-iron-man-unselected"), tag: 0)
        viewController.tabBarItem.selectedImage = #imageLiteral(resourceName: "icon-iron-man").withRenderingMode(.alwaysOriginal)
        let rootViewController : UINavigationController = UINavigationController(rootViewController: viewController)
        rootViewController.navigationBar.prefersLargeTitles = true
        return rootViewController
    }
}
