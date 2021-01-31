
final class DetailsPresenter: Presenter {
    var interactor: DetailsInteractor
    var viewModel: CharactersViewModel?
    var router: DetailsRouter
    weak var view: DetailsViewControllerProtocol?
    
    init(_ interactor: DetailsInteractor, _ router: DetailsRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    typealias Interactor = DetailsInteractor
    typealias Router = DetailsRouter
    
    func onViewDidLoad() {
        guard let viewModel = viewModel else { return }
        view?.showCharacterDetails(viewModel: viewModel)
    }
}
