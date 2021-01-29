import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    
}

final class HomeViewController: ViewController {
    var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CharacterRemoteRepository().fetchCharacters(by: "iron", by: .olderModified, offset: 0, limit: 100) { result in
            dump(result)
        }
    }

}

extension HomeViewController: HomeViewControllerProtocol {
    
}
