@testable import MarvelHeroes
import Quick
import Nimble

final class HomeInteractorTests: QuickSpec {
    var sut: HomeInteractor!
    var characterMockRepository: CharacterMockRepository!
    var outputMock: HomeInteractorOutputMock!
    
    override func spec() {
        describe(".requestData") {
            beforeEach {
                self.outputMock = HomeInteractorOutputMock()
                self.characterMockRepository = CharacterMockRepository()
                self.sut = HomeInteractor(repository: self.characterMockRepository)
                self.sut.output = self.outputMock
            }
            
            context("when data is fetched successfully") {
                it("should return a list of Character") {
                    let characters = [Character(id: 0,
                                                name: "teste",
                                                description: "teste",
                                                modified: nil,
                                                resourceURI: "")]
                    
                    
                    self.characterMockRepository.result = .some(.init(offset: 0, limit: 0, total: 0, count: 0, results: characters))
                    self.sut.fetchCharacters(by: "test")
                    
                    expect(self.outputMock.didFetchCharacters).to(beTrue())
                    expect(self.outputMock.characters?.isEmpty).toNot(beTrue())
                    
                }
            }
            
            context("when no data is fetched") {
                it("should return a error") {
                    enum SomeError: Error {
                        case notFound
                    }
                    
                    self.characterMockRepository.error = .some(SomeError.notFound)
                    self.sut.fetchCharacters(by: nil)
                    
                    expect(self.outputMock.didFoundError).to(beTrue())
                    expect(self.outputMock.error).to(matchError(SomeError.self))
                }
            }
        }
        
    }
    
    class CharacterMockRepository: CharacterRepository {
        var result: PaginableResult<Character>?
        var error: Error?
        
        func fetchCharacters(by name: String?, by order: OrderList?, offset: Int, limit: Int, _ completion: @escaping ResultCompletion<Response<PaginableResult<Character>>>) {
            if let error = error {
                completion(.failure(error))
            } else if let result = result {
                completion(.success(Response(data: result)))
            }
        }
    }
    
    class HomeInteractorOutputMock: HomeInteractorOutputProtocol {
        var didFetchCharacters: Bool = false
        var didFoundError: Bool = false
        
        var error: Error?
        var characters: [Character]?
        func charactersDidFetch(characters: [Character]) {
            didFetchCharacters = true
            self.characters = characters
        }
        
        func charactersDidFetchWithError(error: Error) {
            didFoundError = true
            self.error = error
        }
    }
}


