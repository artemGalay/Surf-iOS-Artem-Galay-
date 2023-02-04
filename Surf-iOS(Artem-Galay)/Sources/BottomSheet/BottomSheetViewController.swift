//
//  BottomSheetViewController.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 3.02.23.
//

import UIKit

final class BottomSheetViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Стажировка в Surf"
        label.textColor = CommonColor.lightBlack
        label.font = UIFont.sfProDisplayBold()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

//    private lazy var categoriesCollectionView: UICollectionView = {
//        let layout = TagFlowLayout()
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
//        collectionView.backgroundColor = .black
//        collectionView.dataSource = self
//        collectionView.dragInteractionEnabled = true
//        collectionView.dropDelegate = self
//        collectionView.dragDelegate = self
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CommonColor.white
        setupHierarchy()
        setupLayout()
    }

    private func setupHierarchy() {
        view.addSubview(titleLabel)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
}
