import UIKit

class DetailsRouter: Router {
    var rootViewController: UIViewController?
    
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    class func viewController(viewModel: CharactersViewModel, repository: CharacterRepository) -> UIViewController {
        let viewController = DetailsViewController()
        let router  = DetailsRouter(rootViewController: viewController)
        let interactor  = DetailsInteractor()
        let presenter  = DetailsPresenter(interactor, router)
        presenter.viewModel = viewModel
        interactor.output = presenter
        viewController.presenter = presenter
        presenter.view = viewController
        return viewController
    }
}
