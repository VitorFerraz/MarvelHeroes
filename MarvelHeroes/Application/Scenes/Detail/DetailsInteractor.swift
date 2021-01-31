protocol DetailInteractorOutputProtocol: AnyObject {
    func showFavorite(entity: CharacterEntity?)
    func removedFavorite()
}
class DetailsInteractor {
    weak var output: DetailInteractorOutputProtocol?
    var repository: FavoriteRepository = FavoriteLocalRepository()
    func checkFavorite(character: Character) {
        repository.fetchCharacters { result in
            switch result {
            case .failure:
                self.output?.showFavorite(entity: nil)
            case.success(let list):
                let object = list.first(where: {$0.id == character.id})
                self.output?.showFavorite(entity: object)
            }
        }
    }
    
    func removeFavorite(entity: CharacterEntity) {
        repository.removeFavoriteCharacter(character: entity)
        output?.removedFavorite()
    }
    
    func addFavority(character: Character) {
        repository.addFavoriteCharacter(character: character) { result in
            self.checkFavorite(character: character)
        }
    }
}
