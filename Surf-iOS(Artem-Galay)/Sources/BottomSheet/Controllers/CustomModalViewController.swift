//
//  CustomModalViewController.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 3.02.23.
//

import UIKit

final class CustomModalViewController: UIViewController {

#warning("Проблема заключается в том, что в первой коллекции при тапе на ячейку, если тап попадает на первую секцию(их там 2, вторая секция для того, чтобы работал бесконечный скрол вправо и влево), при скролле после тапа пропадает выделение ячейки, если тап попадает на вторую секцию при скролле всё норм и выделение не пропадает")

    private var isSelect = false
    private var newElement = ""
    private var categories = Categories.names

    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?

    private var currentContainerHeight: CGFloat = UIScreen.main.bounds.height * 0.5

    private lazy var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var categoriesCollectionView2: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var sendRequestButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отправить заявку", for: .normal)
        button.titleLabel?.font = .sfProDisplayMedium(size: 16)
        button.backgroundColor = CommonColor.lightBlack
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setTitleColor(CommonColor.white, for: .normal)
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let defaultHeight: CGFloat = 330
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 50

    private let descriptionLabel = DescriptionLabel(text: "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты.",
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupPanGesture()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePresentContainer()
    }

    func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(joinUsLabel)
        containerView.addSubview(sendRequestButton)
        containerView.addSubview(categoriesCollectionView)
        containerView.addSubview(description2Label)
        containerView.addSubview(categoriesCollectionView2)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

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
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)

        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }

    @objc private func buttonTapped() {
        !isSelect ? AlertManager.showWrongAlert(on: self) : AlertManager.showCorrectAlert(on: self)
    }

    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {

        let translation = gesture.translation(in: view)
        let isDraggingDown = translation.y > 0
        let newHeight = currentContainerHeight - translation.y

        switch gesture.state {
        case .changed:

            if newHeight > maximumContainerHeight {
                containerViewHeightConstraint?.constant = maximumContainerHeight
                view.layoutIfNeeded()
            }
        case .ended:

            if newHeight < maximumContainerHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)

            }
            else if newHeight > defaultHeight && !isDraggingDown {
                animateContainerHeight(maximumContainerHeight)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.description2Label.isHidden = false
                    self.categoriesCollectionView2.isHidden = false
                }
            }
        default:
            break
        }
    }

    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }

    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }

        currentContainerHeight = height

        self.description2Label.isHidden = true
        self.categoriesCollectionView2.isHidden = true
    }

    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
        description2Label.isHidden = true
        categoriesCollectionView2.isHidden = true
    }
}

extension CustomModalViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionView == categoriesCollectionView ? 2 : 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as? CategoriesCollectionViewCell else { return UICollectionViewCell() }
        cell.categoriesLabel.text = categories[indexPath.row]
        return cell
    }
}

extension CustomModalViewController: UICollectionViewDelegate {

#warning("Перемещение ячейки по тапу на первое место")
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//            newElement = categories[indexPath.item]
//            categories.remove(at: indexPath.item)
//            categories.insert(newElement, at: 0)
//
//            switch indexPath.section {
//            case 0:
//                collectionView.moveItem(at: indexPath, to: IndexPath(item: 0, section: indexPath.section))
//                collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
//            case 1:
//                collectionView.moveItem(at: indexPath, to: IndexPath(item: 0, section: indexPath.section))
//                collectionView.scrollToItem(at: IndexPath(item: 0, section: 1), at: .left, animated: true)
//            default: break
//            }
//
//            isSelect = true
//    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let item = collectionView.cellForItem(at: indexPath)
        if ((item?.isSelected = true) != nil) {
            collectionView.deselectItem(at: indexPath, animated: true)
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            DispatchQueue.main.async {
                collectionView.moveItem(at: indexPath, to: IndexPath(item: 0, section: indexPath.section))
            }
            return true
        }
        return false
//        if collectionView.cellForItem(at: indexPath)?.isSelected == true {
//            collectionView.deselectItem(at: indexPath, animated: true)
//            isSelect = false
//            return false
//        }
//        return true
    }

#warning("Этот метод отвечает за бесконечный скролл вправо и влево, он работает только если есть 2 секции")
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        let frameWidth = categoriesCollectionView.frame.width
        let sectionLength = categoriesCollectionView.contentSize.width / CGFloat(numberOfSections(in: categoriesCollectionView))
        let contentLength = categoriesCollectionView.contentSize.width
        if contentOffsetX <= 0 {
            categoriesCollectionView.contentOffset.x = sectionLength - contentOffsetX
        } else if contentOffsetX >= contentLength - frameWidth {
            categoriesCollectionView.contentOffset.x = contentLength - sectionLength - frameWidth
        }
    }
}

//extension CustomModalViewController: UICollectionViewDelegateFlowLayout {
//    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    //        let nameFont = UIFont.sfProDisplayMedium(size: 14)
//    //        let nameAttributes = [NSAttributedString.Key.font : nameFont as Any]
//    //        let nameWidth = categories[indexPath.item].size(withAttributes: nameAttributes).width + 50
//    //        return CGSize(width: nameWidth, height: 44)
//    //    }
//    //}
//}
