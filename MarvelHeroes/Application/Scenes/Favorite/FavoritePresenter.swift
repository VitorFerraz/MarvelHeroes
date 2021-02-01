//
//  FavoritePresenter.swift
//  MarvelHeroes
//
//  Created by Vitor Ferraz Varela on 31/01/21.
//

import Foundation

struct FavoriteViewModel: Hashable {
    var entity: CharacterEntity
    var name: String? {
        entity.name
    }
    
    var thumbnail: String? {
        entity.thumbnail
    }
}

final class FavoritePresenter: Presenter {
    typealias Interactor = FavoriteInteractor
    typealias Router = FavoriteRouter
    
    weak var view: FavoriteViewControllerProtocol?
    var router: FavoriteRouter
    var interactor: FavoriteInteractor
    var favoriteViewModel: [FavoriteViewModel] = []

    
    init(_ interactor: FavoriteInteractor, _ router: FavoriteRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func onViewDidLoad() {
        interactor.fetchList()
    }
    
}

extension FavoritePresenter: FavoriteInteractorOutputProtocol {
    func showFavorite(entities: [CharacterEntity]) {
        self.favoriteViewModel = entities.map(FavoriteViewModel.init)
        view?.showFavorites()
    }
}
