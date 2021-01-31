//
//  FavoriteLocalRepository.swift
//  MarvelHeroes
//
//  Created by Vitor Ferraz Varela on 31/01/21.
//

import Foundation

struct FavoriteLocalRepository: FavoriteRepository {
    func fetchCharacters(_ completion: @escaping ResultCompletion<[CharacterEntity]>) {
        do {
            let entities: [CharacterEntity] = try DatabaseController.context.fetch(CharacterEntity.fetchRequest())
            completion(.success(entities))
        } catch {
            completion(.failure(error))
        }
    }
    
    func removeFavoriteCharacter(character: CharacterEntity) {
        DatabaseController.context.delete(character)

    }
    
    func addFavoriteCharacter(character: Character ,_ completion: @escaping ResultCompletion<Void>) {
        let entity = CharacterEntity(context: DatabaseController.context)
        entity.id = Int64(character.id)
        entity.name = character.name
        entity.charDescription = character.description
        entity.thumbnail = character.thumbnail?.url
        DatabaseController.saveContext()
        completion(.success(()))
    }
}
