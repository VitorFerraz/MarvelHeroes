@testable import MarvelHeroes
import Quick
import Nimble
final class DetailsPresenterTests: QuickSpec {
    
    override func spec() {
        var sut: DetailsPresenter!
        var detailViewSpy: DetailViewSpy!
        var detailInteractorMock: DetailInteractorMock!

        describe(".DetailPresenter") {
            beforeEach {
                detailViewSpy = DetailViewSpy()
                detailInteractorMock = DetailInteractorMock()
                sut = DetailsPresenter(detailInteractorMock, DetailsRouter(rootViewController: UIViewController()))
                detailInteractorMock.output = sut
                sut.view = detailViewSpy
                
            }
            context("view is loaded") {
                it("show character information") {
                    sut.viewModel = .init(character: .init(id: 0, name: "", description: "", modified: nil, resourceURI: nil, thumbnail: nil))
                    sut.onViewDidLoad()
                    
                    expect(detailInteractorMock.didCheckFavorite).to(beTrue())
                    expect(detailInteractorMock.character).toNot(beNil())
                }
            }
            
            context("toogle favorite") {
                it("saved character") {
                    sut.viewModel = .init(character: .init(id: 0, name: "", description: "", modified: nil, resourceURI: nil, thumbnail: nil))
                    sut.toogleFavorite()
                    
                    expect(detailInteractorMock.didAddFavorite).to(beTrue())
                }
            }
        }
        
    }
    
    class DetailInteractorMock: DetailsInteractorProtocol {
        var error: Error?
        var character: Character?
        var didCheckFavorite: Bool = false
        var didRemoveFavorite: Bool = false
        var didAddFavorite: Bool = false
        
        func checkFavorite(character: Character) {
            self.character = character
            didCheckFavorite = true
        }
        
        func removeFavorite(entity: CharacterEntity) {
            didRemoveFavorite = true
        }
        
        func addFavority(character: Character) {
            didAddFavorite = true
        }
     
        weak var output: DetailInteractorOutputProtocol?

    }
    
    class DetailViewSpy: DetailsViewControllerProtocol {
        var didShowCharacterDetails: Bool = false
        var viewModel: CharactersViewModel?
        
        func showCharacterDetails(viewModel: CharactersViewModel, isFavorite: Bool) {
            didShowCharacterDetails = true
            self.viewModel = viewModel
        }
        
        func updateFavorite(isFavorite: Bool) {
            
        }
        
        
    }
    
}
