struct CharacterRemoteRepository: CharacterRepository {
    private let network = NetworkManager<CharacterService>()
    func fetchCharacters(by name: String?, by order: OrderList?, offset: Int, limit: Int, _ completion: @escaping ResultCompletion<Response<PaginableResult<Character>>>) {
        network.request(service: CharacterService.getCharacter(byName: name, orderBy: order, offset: offset, limit: limit), result: completion)
    }
    
}
