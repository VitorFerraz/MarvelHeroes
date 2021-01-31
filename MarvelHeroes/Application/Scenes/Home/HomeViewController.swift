import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func showCharacters(viewModels: [CharactersViewModel])
    func showError(error: Error)
    func showEmpty()
}

final class HomeViewController: ViewController {
    var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        CharacterRemoteRepository().fetchCharacters(by: "iron", by: .olderModified, offset: 0, limit: 100) { result in
//            dump(result)
//        }
    }

}

extension HomeViewController: HomeViewControllerProtocol {
    func showCharacters(viewModels: [CharactersViewModel]) {
        
    }
    
    func showError(error: Error) {
        
    }
    
    func showEmpty() {
        
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Debounce.input(searchText, current: searchBar.text ?? "") {  [weak self] in
            print($0)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

enum Debounce<T: Equatable> {
    static func input(_ input: T, delay: TimeInterval = 0.3, current: @escaping @autoclosure () -> T, perform: @escaping (T) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            guard input == current() else { return }
            perform(input)
        }
    }
}
