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
        button.layer.cornerRadius = Metrics.buttonCornerRadius
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
        view.layer.cornerRadius = Metrics.containerViewCornerRadius
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

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor,
                                            constant: Metrics.titleLabelTop),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                constant: Metrics.titleLabelLeading),

            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                           constant: Metrics.infoLabelTop),
            infoLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                               constant: Metrics.infoLabelLeadingTrailing),
            infoLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                constant: -Metrics.infoLabelLeadingTrailing),

            carouselCollectionView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor,
                                                        constant: Metrics.carouselsTop),
            carouselCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            carouselCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            carouselCollectionView.heightAnchor.constraint(equalToConstant: Metrics.carouselHeight),

            awardLabel.topAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor,
                                            constant: Metrics.awardLabelTop),
            awardLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                constant: Metrics.awardLabelLeadingTrailing),
            awardLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                 constant: -Metrics.awardLabelLeadingTrailing),

            doubleCarouselCollectionView.topAnchor.constraint(equalTo: awardLabel.bottomAnchor,
                                                              constant: Metrics.carouselsTop),
            doubleCarouselCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            doubleCarouselCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            doubleCarouselCollectionView.heightAnchor.constraint(equalToConstant: Metrics.doubleCarouselHeight),

            wantToJoinUsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                       constant: Metrics.wantToJoinUsLabelTop),
            wantToJoinUsLabel.centerYAnchor.constraint(equalTo: sendRequestButton.centerYAnchor),

            sendRequestButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                        constant: Metrics.sendRequestButtonTrailing),
            sendRequestButton.heightAnchor.constraint(equalToConstant: Metrics.sendRequestButtonHeight),
            sendRequestButton.widthAnchor.constraint(equalToConstant: Metrics.sendRequestButtonWidth),
            sendRequestButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,
                                                      constant: Metrics.sendRequestButtonBottom)
        ])

        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: Constants.defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                              constant: Constants.defaultHeight)
        
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
}

enum Metrics {
    static let buttonCornerRadius: CGFloat = 30
    static let containerViewCornerRadius: CGFloat = 25
    static let titleLabelTop: CGFloat = 24
    static let titleLabelLeading: CGFloat = 20
    static let infoLabelTop: CGFloat = 12
    static let infoLabelLeadingTrailing: CGFloat = 20
    static let carouselsTop: CGFloat = 12
    static let carouselHeight: CGFloat = 50
    static let awardLabelTop: CGFloat = 24
    static let awardLabelLeadingTrailing: CGFloat = 20
    static let doubleCarouselHeight: CGFloat = 100
    static let wantToJoinUsLabelTop: CGFloat = 20
    static let sendRequestButtonTrailing: CGFloat = -20
    static let sendRequestButtonHeight: CGFloat = 60
    static let sendRequestButtonWidth: CGFloat = 219
    static let sendRequestButtonBottom: CGFloat = -58
}
