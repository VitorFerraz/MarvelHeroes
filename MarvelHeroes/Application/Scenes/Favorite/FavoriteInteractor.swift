//
//  FavoriteInteractor.swift
//  MarvelHeroes
//
//  Created by Vitor Ferraz Varela on 31/01/21.
//

import Foundation

protocol FavoriteInteractorOutputProtocol: AnyObject {
    func showFavorite(entities: [CharacterEntity])
}
class FavoriteInteractor {
    weak var output: FavoriteInteractorOutputProtocol?
    var repository: FavoriteRepository = FavoriteLocalRepository()
    
    func fetchList() {
        repository.fetchCharacters { result in
            switch result {
            case .failure:
                self.output?.showFavorite(entities: [])
            case.success(let list):
                self.output?.showFavorite(entities: list)
            }
        }
    }

}
