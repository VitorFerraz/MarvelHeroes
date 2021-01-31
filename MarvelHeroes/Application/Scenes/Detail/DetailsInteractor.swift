protocol DetailInteractorOutputProtocol: AnyObject {
    func showData()
}
class DetailsInteractor {
    weak var output: HomeInteractorOutputProtocol?

    func showData() {
        
    }
}
