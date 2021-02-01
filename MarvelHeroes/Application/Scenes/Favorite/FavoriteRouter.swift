import UIKit
class FavoriteRouter: Router {
    var rootViewController: UIViewController?
    
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    class func viewController(repository: FavoriteRepository) -> UIViewController {
        let viewController = FavoriteViewController()
        let router  = FavoriteRouter(rootViewController: viewController)
        let interactor  = FavoriteInteractor()
        let presenter  = FavoritePresenter(interactor, router)
        interactor.output = presenter
        presenter.view = viewController
        viewController.presenter = presenter
        viewController.tabBarItem = UITabBarItem(title: NSLocalizedString("Favorites",comment: ""), image: #imageLiteral(resourceName: "icon-american-cap-unselected"), tag: 0)
        viewController.tabBarItem.selectedImage = #imageLiteral(resourceName: "icon-american-cap").withRenderingMode(.alwaysOriginal)
        let rootViewController : UINavigationController = UINavigationController(rootViewController: viewController)
        rootViewController.navigationBar.prefersLargeTitles = true
        return rootViewController
    }
    
    func presentDetailsScreen(_ viewModel: CharactersViewModel) {
        let vc = DetailsRouter.viewController(viewModel: viewModel, repository: CharacterRemoteRepository())
        rootViewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
