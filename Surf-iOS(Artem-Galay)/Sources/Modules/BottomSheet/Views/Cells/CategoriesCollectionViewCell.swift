//
//  CategoriesCollectionViewCell.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 5.02.23.
//

import UIKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? Color.lightBlack : Color.lightGray
            categoriesLabel.textColor =  isSelected ? Color.lightGray : Color.lightBlack
        }
    }
    
    //MARK: - Properties
    
    static let identifier = "CollectionViewCell"
    
    // MARK: - UIElements
    
    let categoriesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfProDisplayMedium(size: 14)
        label.textColor = Color.lightBlack
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    
    private func configuration() {
        backgroundColor = Color.lightGray
        layer.cornerRadius = 12
    }
    
    private func setupHierarchy() {
        addSubview(categoriesLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            categoriesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            categoriesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            categoriesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24 ),
            categoriesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
}
