import Foundation

protocol FavoriteRepository {
    func fetchCharacters(_ completion: @escaping ResultCompletion<[CharacterEntity]>)
    func removeFavoriteCharacter(character: CharacterEntity)
    func addFavoriteCharacter(character: Character ,_ completion: @escaping ResultCompletion<Void>)
}
