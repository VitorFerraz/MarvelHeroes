import UIKit

protocol DetailsViewControllerProtocol: AnyObject {
    func showCharacterDetails(viewModel: CharactersViewModel, isFavorite: Bool)
    func updateFavorite(isFavorite: Bool)

}


final class DetailsViewController: ViewController {
    var presenter: DetailsPresenter?
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.font = StyleGuide.CardLabel.titleFont
        return label
    }()
    
    private var descriptionLabel: UILabel = {
       let label = UILabel()
        label.font = StyleGuide.CardLabel.descriptionFont
        label.numberOfLines = 3
        return label
    }()
    
    var characterImageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = StyleGuide.Colors.grayTheme
        iv.contentMode   = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var containerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, characterImageView])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }
    
    override func addViewHierarchy() {
        view.addSubview(containerStack)
    }
    
    override func setupConstraints() {
        containerStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: view.bottomAnchor,
                              trailing: view.trailingAnchor)
        
    }
    
    override func configureViews() {
        navigationItem.rightBarButtonItem = .init(image: #imageLiteral(resourceName: "icon_favorite_no_selected").withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.done, target: self, action: #selector(favoriteButtonTapped))
    }
    
    @objc func favoriteButtonTapped() {
        presenter?.toogleFavorite()
    }
    
    func updateBarButton(isFavorite: Bool) {
        let image = isFavorite ?  #imageLiteral(resourceName: "icon_favorite_selected").withRenderingMode(.alwaysOriginal) :  #imageLiteral(resourceName: "icon_favorite_no_selected").withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = .init(image: image, style: UIBarButtonItem.Style.done, target: self, action: #selector(favoriteButtonTapped))

    }

}

extension DetailsViewController: DetailsViewControllerProtocol {
    func updateFavorite(isFavorite: Bool) {
        updateBarButton(isFavorite: isFavorite)
    }
    
    func showCharacterDetails(viewModel: CharactersViewModel, isFavorite: Bool) {
        titleLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        characterImageView.setImageFrom(url: viewModel.thumbnail)
        updateBarButton(isFavorite: isFavorite)
    }
}
