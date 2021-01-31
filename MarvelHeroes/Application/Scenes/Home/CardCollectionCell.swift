//
//  CardCollectionCell.swift
//  MarvelHeroes
//
//  Created by Vitor Ferraz Varela on 31/01/21.
//

import UIKit

class CardCollectionCell: CollectionViewCell {
    var viewModel: CharactersViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            configureWith(viewModel: viewModel)
        }
    }
    
    var cardImageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = StyleGuide.Colors.grayTheme
        iv.contentMode   = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font             = StyleGuide.CardLabel.font
        label.textColor        = StyleGuide.CardLabel.textColor
        label.numberOfLines    = 2
        label.textAlignment = .center
        return label
    }()
    
    var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icon_favorite_no_selected"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "icon_favorite_selected"), for: .selected)
        return button
    }()
    
    lazy var containerStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [cardImageView, titleLabel])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    override func configureViews() {
        clean()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clean()
    }
    
    override func addViewHierarchy() {
        contentView.addSubview(containerStack)
       
    }
    
    override func setupConstraints() {
        containerStack.anchor(top: contentView.topAnchor,
                              leading: contentView.leadingAnchor,
                              bottom: contentView.bottomAnchor,
                              trailing: contentView.trailingAnchor)
    }
    
    
    private func setup() {
        layoutIfNeeded()
        layer.cornerRadius          = 3.0
        clipsToBounds               = true
        backgroundColor = StyleGuide.Colors.grayTheme
    }
    
    private func clean() {
        cardImageView.image = nil
        titleLabel.text = nil
    }
    
    func configureWith(viewModel: CharactersViewModel) {
        titleLabel.text           = viewModel.name
        favoriteButton.isSelected = false
        cardImageView.setImageFrom(url: viewModel.thumbnail)
    }
}
