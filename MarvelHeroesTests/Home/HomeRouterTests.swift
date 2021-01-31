@testable import MarvelHeroes
import Quick
import Nimble
final class HomeRouterTests: QuickSpec {
    
    override func spec() {
        var rootViewController: UIViewController!
        describe(".HomeRouter") {
            beforeEach {
                rootViewController = HomeRouter.viewController(repository: CharacterRemoteRepository())
            }
            
            context("call viewController") {
                it("setup router with all classes ") {
                    let nav = rootViewController as? UINavigationController
                    let homeViewController = nav?.viewControllers.first as? HomeViewController
                    let presenter = homeViewController?.presenter
                    expect(homeViewController).toNot(beNil())
                    expect(presenter).toNot(beNil())
                }
            }
        }
    }
}
