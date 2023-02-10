//
//  CustomModalView.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 10.02.23.
//

import UIKit

class CustomModalView: UIView {

    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?

    lazy var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    lazy var categoriesCollectionView2: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    lazy var sendRequestButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отправить заявку", for: .normal)
        button.titleLabel?.font = .sfProDisplayMedium(size: 16)
        button.backgroundColor = CommonColor.lightBlack
//        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setTitleColor(CommonColor.white, for: .normal)
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let defaultHeight: CGFloat = 330
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 50

    let descriptionLabel = DescriptionLabel(text: "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты.",
                                                    numberOfLines: 3)
    private let joinUsLabel = DescriptionLabel(text: "Хочешь к нам?",
                                               numberOfLines: 1)
    let description2Label = DescriptionLabel(text: "Получай стипендию, выстраивай удобный график, работай на современном железе.",
                                                     numberOfLines: 2)

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Стажировка в Surf"
        label.textColor = CommonColor.lightBlack
        label.font = .sfProDisplayBold(size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func commonInit() {
        backgroundColor = .clear
        setupHierarchy()
        setupLayout()
    }

    private func setupHierarchy() {
        addSubview(containerView)
        containerView.addSubviews([
            titleLabel,
            descriptionLabel,
            joinUsLabel,
            sendRequestButton,
            categoriesCollectionView,
            description2Label,
            categoriesCollectionView2
        ])
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            categoriesCollectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 50),

            description2Label.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor, constant: 24),
            description2Label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            description2Label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            categoriesCollectionView2.topAnchor.constraint(equalTo: description2Label.bottomAnchor, constant: 12),
            categoriesCollectionView2.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            categoriesCollectionView2.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            categoriesCollectionView2.heightAnchor.constraint(equalToConstant: 100),

            joinUsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            joinUsLabel.centerYAnchor.constraint(equalTo: sendRequestButton.centerYAnchor),

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

