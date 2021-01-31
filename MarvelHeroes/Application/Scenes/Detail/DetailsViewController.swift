import UIKit

protocol DetailsViewControllerProtocol: AnyObject {
    func showCharacterDetails(viewModel: CharactersViewModel)
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

}

extension DetailsViewController: DetailsViewControllerProtocol {
    func showCharacterDetails(viewModel: CharactersViewModel) {
        titleLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        characterImageView.setImageFrom(url: viewModel.thumbnail)
    }
}
