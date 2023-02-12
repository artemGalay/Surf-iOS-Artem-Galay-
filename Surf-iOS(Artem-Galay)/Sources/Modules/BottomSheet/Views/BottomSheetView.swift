//
//  BottomSheet.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 10.02.23.
//

import UIKit

final class BottomSheetView: UIView {

    // MARK: - Properties

    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?

    private let defaultHeight: CGFloat = 330
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 50

    // MARK: - UIElements

    let carouselCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = Color.white
        collectionView.allowsMultipleSelection = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    let doubleCarouselCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        collectionView.backgroundColor = Color.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    lazy var sendRequestButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Strings.BottomSheet.sendRequestButton, for: .normal)
        button.titleLabel?.font = .sfProDisplayMedium(size: 16)
        button.backgroundColor = Color.lightBlack
        button.setTitleColor(Color.white, for: .normal)
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let awardLabel = DefaultLabel(text: Strings.BottomSheet.awardLabel,
                                  numberOfLines: 2,
                                  font: .sfProDisplayMedium(size: 14),
                                  textColor: Color.gray)

    private let titleLabel = DefaultLabel(text: Strings.BottomSheet.titleLabel,
                                          numberOfLines: 1,
                                          font: .sfProDisplayBold(size: 24),
                                          textColor: Color.lightBlack)

    private let infoLabel = DefaultLabel(text: Strings.BottomSheet.infoLabel,
                                         numberOfLines: 3,
                                         font: .sfProDisplayMedium(size: 14),
                                         textColor: Color.gray)

    private let wantToJoinUsLabel = DefaultLabel(text: Strings.BottomSheet.wantToJoinUsLabel,
                                                 numberOfLines: 1,
                                                 font: .sfProDisplayMedium(size: 14),
                                                 textColor: Color.gray)

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Configuration
    private func commonInit() {
        backgroundColor = .clear
        setupHierarchy()
        setupLayout()
    }

    private func setupHierarchy() {
        addSubview(containerView)
        containerView.addSubviews([
            titleLabel,
            infoLabel,
            wantToJoinUsLabel,
            sendRequestButton,
            carouselCollectionView,
            awardLabel,
            doubleCarouselCollectionView
        ])
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),

            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            infoLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            carouselCollectionView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 12),
            carouselCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            carouselCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            carouselCollectionView.heightAnchor.constraint(equalToConstant: 50),

            awardLabel.topAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor, constant: 24),
            awardLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            awardLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            doubleCarouselCollectionView.topAnchor.constraint(equalTo: awardLabel.bottomAnchor, constant: 12),
            doubleCarouselCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            doubleCarouselCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            doubleCarouselCollectionView.heightAnchor.constraint(equalToConstant: 100),

            wantToJoinUsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            wantToJoinUsLabel.centerYAnchor.constraint(equalTo: sendRequestButton.centerYAnchor),

            sendRequestButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            sendRequestButton.heightAnchor.constraint(equalToConstant: 60),
            sendRequestButton.widthAnchor.constraint(equalToConstant: 219),
            sendRequestButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -58)
        ])

        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: defaultHeight)

        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
}
