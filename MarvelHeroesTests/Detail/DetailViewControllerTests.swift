import SnapshotTesting
import SwiftUI
import Quick
import Nimble
@testable import MarvelHeroes

class DetailsViewControllerTests: QuickSpec {
    var characterMockRepository: CharacterMockRepository!

    override func spec() {

        describe("Snapshot DetailsViewController Test") {
            beforeEach {
                self.characterMockRepository = CharacterMockRepository()

            }
            context("in multiple languages") {
                context("and multiple devices") {
                    it("shows the hero details with title and description") {
                       
                        let devices: [(String, ViewImageConfig)] = [("iPhoneX", .iPhoneX),
                                                                    ("iPhoneXr", .iPhoneXr),
                                                                    ("iPhoneXsMax", .iPhoneXsMax)]
                        //Used for SwiftUI
                        let languages: [Locale] = [Locale(identifier: "pt-br"),
                                                   Locale(identifier: "en")]
                        
                        let viewModel = CharactersViewModel(character: Character(id: 0,
                                                                                 name: "teste",
                                                                                 description: "teste",
                                                                                 modified: nil,
                                                                                 resourceURI: ""))
                        languages.forEach { (language) in
                            devices.forEach { device in
                                let root = DetailsRouter.viewController(viewModel: viewModel, repository: CharacterMockRepository())
                                root.loadViewIfNeeded()
                                let named = "Device-\(device.0)-Language-\(language)"
                                let expectation = XCTestExpectation(description: named)

                                putInViewHierarchy(root)
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
                                    expectation.fulfill()
                                })
                                self.wait(for: [expectation], timeout: .infinity)
                                let width = device.1.size?.width ?? 0.0
                                let height = device.1.size?.height ?? 0.0
                                assertSnapshot(matching: root, as: .image(size: CGSize(width: width, height: height)), named: named)
                            }
                        }
                    }
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
}

