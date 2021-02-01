import UIKit

typealias FavoriteDataSource = UICollectionViewDiffableDataSource<FavSection, FavoriteViewModel>
typealias FavoriteSnapshot = NSDiffableDataSourceSnapshot<FavSection, FavoriteViewModel>


protocol FavoriteViewControllerProtocol: AnyObject {
    func showFavorites()

}

enum FavSection {
    case main
}

final class FavoriteViewController: ViewController, UICollectionViewDelegateFlowLayout, UICollisionBehaviorDelegate {
    
    var presenter: FavoritePresenter?
    private lazy var dataSource = makeDataSource()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(FavoriteCardCollectionCell.self, forCellWithReuseIdentifier: StyleGuide.CollectionView.itemIdentifier)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
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
        presenter?.onViewDidLoad()
        setup()
    }
    
    override func addViewHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func setupConstraints() {
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: view.bottomAnchor,
                              trailing: view.trailingAnchor)
    }
    
    override func configureViews() {
        
        title = NSLocalizedString("Favorite heroes",comment: "")
    }
    
    func makeDataSource() -> FavoriteDataSource {
        let dataSource = FavoriteDataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, viewModel) ->
                UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: StyleGuide.CollectionView.itemIdentifier,
                    for: indexPath) as? FavoriteCardCollectionCell
                cell?.viewModel = viewModel
                return cell
            })
        return dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = FavoriteSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(presenter?.favoriteViewModel ?? [])
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

extension FavoriteViewController: FavoriteViewControllerProtocol {
    func showFavorites() {
        applySnapshot()
    }
    
    
}
