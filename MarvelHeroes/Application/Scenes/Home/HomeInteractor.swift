
protocol HomeInteractorOutputProtocol: AnyObject {
    func charactersDidFetch(characters: [Character])
    func charactersDidFetchWithError(error: Error)
}

protocol HomeInteractorProtocol: AnyObject {
    func fetchCharacters(by name: String?,
                         by order: OrderList?,
                         offset: Int, limit: Int)
}

class HomeInteractor: HomeInteractorProtocol {
    private var repository: CharacterRepository
    weak var output: HomeInteractorOutputProtocol?
    
    init(repository: CharacterRepository = CharacterRemoteRepository()) {
        self.repository = repository
    }
    
    func fetchCharacters(by name: String?,
                         by order: OrderList? = .recentlyModified,
                         offset: Int = 0, limit: Int = 20) {
        repository.fetchCharacters(by: name, by: order, offset: offset, limit: limit) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.output?.charactersDidFetchWithError(error: error)
            case .success(let response):
                self?.output?.charactersDidFetch(characters: response.data?.results ?? [])
            }
        }
    }
}
