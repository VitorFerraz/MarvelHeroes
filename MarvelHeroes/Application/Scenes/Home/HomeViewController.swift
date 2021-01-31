import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func showCharacters()
    func showError(error: Error)
    func showEmpty()
}

enum Section {
    case main
}

typealias HomeDataSource = UICollectionViewDiffableDataSource<Section, CharactersViewModel>
typealias HomeSnapshot = NSDiffableDataSourceSnapshot<Section, CharactersViewModel>


final class HomeViewController: ViewController, UICollectionViewDelegateFlowLayout {
    var presenter: HomePresenter?
    private lazy var dataSource = makeDataSource()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController()
        controller.searchBar.placeholder = "Search for a hero..."
        controller.searchBar.delegate = self
        controller.obscuresBackgroundDuringPresentation = false
        return controller
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(CardCollectionCell.self, forCellWithReuseIdentifier: StyleGuide.CollectionView.itemIdentifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let collectionViewLayout: UICollectionViewFlowLayout = .init()
        collectionViewLayout.itemSize                        = StyleGuide.CollectionView.itemSize
        collectionViewLayout.minimumLineSpacing              = StyleGuide.CollectionView.minimumLineSpacing
        collectionViewLayout.minimumInteritemSpacing         = StyleGuide.CollectionView.minimumInteritemSpacing
        collectionViewLayout.scrollDirection                 = .horizontal
        collectionViewLayout.sectionInset                    = StyleGuide.CollectionView.sectionInset
        return collectionViewLayout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func addViewHierarchy() {
        navigationItem.searchController = searchController
        view.addSubview(collectionView)
    }
    
    override func setupConstraints() {
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: view.bottomAnchor,
                              trailing: view.trailingAnchor)
    }
    
    override func configureViews() {
        title = "Choose your hero"
    }
    
    func makeDataSource() -> HomeDataSource {
        let dataSource = HomeDataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, viewModel) ->
                UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: StyleGuide.CollectionView.itemIdentifier,
                    for: indexPath) as? CardCollectionCell
                cell?.viewModel = viewModel
                return cell
            })
        return dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = HomeSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(presenter?.charactersViewModel ?? [])
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
}

extension HomeViewController: HomeViewControllerProtocol {
    func showCharacters() {
        applySnapshot()
    }
    
    func showError(error: Error) {
        showSimpleAlert(title: "Ops", text: error.localizedDescription, cancelButtonTitle: "OK")
    }
    
    func showEmpty() {
        applySnapshot()
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Debounce.input(searchText, current: (searchBar.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)) {  [weak self] in
            $0.isEmpty ? self?.presenter?.clearSearch() : self?.presenter?.performSearch(by: $0)
        }
    }
}

enum Debounce<T: Equatable> {
    static func input(_ input: T, delay: TimeInterval = 0.6, current: @escaping @autoclosure () -> T, perform: @escaping (T) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            guard input == current() else { return }
            perform(input)
        }
    }
}
