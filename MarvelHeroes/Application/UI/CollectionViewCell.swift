//
//  CollectionViewCell.swift
//  MarvelHeroes
//
//  Created by Vitor Ferraz Varela on 31/01/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell, ViewConfigurator {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViewHierarchy() {}
    
    func setupConstraints() {}
    
    func configureViews() {}
    
}
