import UIKit

final class HomePresenter: Presenter {
    var interactor: HomeInteractorProtocol
    var router: HomeRouter
    weak var view: HomeViewControllerProtocol?

    typealias Interactor = HomeInteractorProtocol
    typealias Router = HomeRouter
    
    required init(_ interactor: HomeInteractorProtocol, _ router: HomeRouter) {
        self.interactor = interactor
        self.router = router
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func charactersDidFetchWithError(error: Error) {
        
    }
    
    func charactersDidFetch(characters: [Character]) {
        
    }
    
    
}

