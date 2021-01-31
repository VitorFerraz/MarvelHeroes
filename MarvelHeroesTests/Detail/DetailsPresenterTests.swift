@testable import MarvelHeroes
import Quick
import Nimble
final class DetailsPresenterTests: QuickSpec {
    
    override func spec() {
        var sut: DetailsPresenter!
        var detailViewSpy: DetailViewSpy!
        
        describe(".DetailPresenter") {
            beforeEach {
                detailViewSpy = DetailViewSpy()
                sut = DetailsPresenter(DetailsInteractor(), DetailsRouter(rootViewController: UIViewController()))
                sut.view = detailViewSpy
                
            }
            context("view is loaded") {
                it("show character information") {
                    sut.viewModel = .init(character: .init(id: 0, name: "", description: "", modified: nil, resourceURI: nil, thumbnail: nil))
                    sut.onViewDidLoad()
                    
                    expect(detailViewSpy.didShowCharacterDetails).to(beTrue())
                    expect(detailViewSpy.viewModel).toNot(beNil())
                }
            }
        }
        
    }
    
    class DetailViewSpy: DetailsViewControllerProtocol {
        var didShowCharacterDetails: Bool = false
        var viewModel: CharactersViewModel?
        func showCharacterDetails(viewModel: CharactersViewModel) {
            didShowCharacterDetails = true
            self.viewModel = viewModel
        }
    }
    
}
