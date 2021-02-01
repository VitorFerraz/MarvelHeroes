
final class DetailsPresenter: Presenter {
    var interactor: DetailsInteractorProtocol
    var viewModel: CharactersViewModel?
    var router: DetailsRouter
    
    var isFavorite: Bool {
        entity != nil
    }
    var entity: CharacterEntity?
    
    weak var view: DetailsViewControllerProtocol?
    
    init(_ interactor: DetailsInteractorProtocol, _ router: DetailsRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    typealias Interactor = DetailsInteractorProtocol
    typealias Router = DetailsRouter
    
    func onViewDidLoad() {
        guard let viewModel = viewModel else { return }
        interactor.checkFavorite(character: viewModel.character)
    }
    
    func toogleFavorite() {
        if let entity = entity {
            interactor.removeFavorite(entity: entity)
        } else if let character = viewModel?.character {
            interactor.addFavority(character: character)
        }
    }
}

extension DetailsPresenter: DetailInteractorOutputProtocol {
    func showFavorite(entity: CharacterEntity?) {
        guard let viewModel = viewModel else { return }
        self.entity = entity
        view?.showCharacterDetails(viewModel: viewModel, isFavorite: isFavorite)
    }
    
    func removedFavorite() {
        self.entity = nil
        view?.updateFavorite(isFavorite: isFavorite)
    }
}
