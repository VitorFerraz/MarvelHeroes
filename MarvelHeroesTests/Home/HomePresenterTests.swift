@testable import MarvelHeroes
import Quick
import Nimble
final class HomePresenterTests: QuickSpec {
    
    override func spec() {
        var sut: HomePresenter!
        var homeInteractorMock: HomeInteractorMock!
        describe(".HomePresenter") {
            beforeEach {
                homeInteractorMock = HomeInteractorMock()
                sut = HomePresenter(homeInteractorMock, HomeRouter(rootViewController: UIViewController()))
                homeInteractorMock.output = sut
            }
            
            context("when user search a name") {
                it("should return a list of heroes matching the search") {
                    homeInteractorMock.characters = [.init(id: 0, name: "iron man", description: "", modified: nil, resourceURI: nil)]
                    
                    sut.performSearch(by: "iron man")
                    
                    expect(homeInteractorMock.didFetchCharacters).to(beTrue())
                    expect(homeInteractorMock.characters?.isEmpty).to(beFalse())
                    let character = homeInteractorMock.characters?.first
                    expect(character?.name).to(match("iron man"))
                }
            }
            
            context("when user clears search") {
                it("should clear the search or fetch values") {
                    homeInteractorMock.characters = [.init(id: 0, name: "iron man", description: "", modified: nil, resourceURI: nil)]
                    
                    sut.clearSearch()
                    
                    expect(sut.numberOfCharacters).to(equal(0))
                }
            }
            
            context("get hero from a valid position") {
                it("should return a hero") {
                    homeInteractorMock.characters = [.init(id: 0, name: "iron man", description: "", modified: nil, resourceURI: nil)]
                    sut.performSearch(by: "iron man")
                    let heroe = sut.charactersFor(rowAt: 0)
                    
                    expect(heroe).toNot(beNil())
                }
            }
            
            context("get hero from a invalid position") {
                it("should return nothing") {
                    homeInteractorMock.characters = [.init(id: 0, name: "iron man", description: "", modified: nil, resourceURI: nil)]
                    sut.performSearch(by: "iron man")

                    let heroe = sut.charactersFor(rowAt: -1)
                    
                    expect(heroe).to(beNil())
                }
            }
        }
    }
    
    class HomeInteractorMock: HomeInteractorProtocol {
        var didFetchCharacters: Bool = false
        var didFoundError: Bool = false
        weak var output: HomeInteractorOutputProtocol?

        
        var error: Error?
        var characters: [Character]?
        
        func fetchCharacters(by name: String?, by order: OrderList?, offset: Int, limit: Int) {
            if let error = error {
                didFoundError = true
                self.error = error
                output?.charactersDidFetchWithError(error: error)
            } else if let characters = characters {
                didFetchCharacters = true
                self.characters = characters
                output?.charactersDidFetch(characters: characters)
            }
        }

    }
}
