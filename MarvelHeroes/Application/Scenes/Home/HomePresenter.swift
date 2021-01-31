import UIKit

protocol HomePresenterProtocol {
    var numberOfCharacters: Int { get }
    func performSearch(by name: String)
    func clearSearch()
    func charactersFor(rowAt index: Int) -> CharactersViewModel?
}

final class HomePresenter: Presenter, HomePresenterProtocol {
    var interactor: HomeInteractorProtocol
    var router: HomeRouter
    weak var view: HomeViewControllerProtocol?
    private var charactersViewModel: [CharactersViewModel] = [] {
        didSet {
            charactersViewModel.isEmpty ? view?.showEmpty() : view?.showCharacters(viewModels: self.charactersViewModel)
        }
    }
    typealias Interactor = HomeInteractorProtocol
    typealias Router = HomeRouter
    
    required init(_ interactor: HomeInteractorProtocol, _ router: HomeRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    var numberOfCharacters: Int {
        return charactersViewModel.count
    }
    
    func performSearch(by name: String) {
        interactor.fetchCharacters(by: name, by: .recentlyModified, offset: 0, limit: 100)
    }
    
    func clearSearch() {
        charactersViewModel.removeAll()
    }
    
    func charactersFor(rowAt index: Int) -> CharactersViewModel? {
        charactersViewModel.indices.contains(index) ? charactersViewModel[index] : nil
    }
    
    
}

struct CharactersViewModel {
    var character: Character
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func charactersDidFetchWithError(error: Error) {
        clearSearch()
        view?.showError(error: error)
    }
    
    func charactersDidFetch(characters: [Character]) {
        self.charactersViewModel = characters.map(CharactersViewModel.init)
    }
}

