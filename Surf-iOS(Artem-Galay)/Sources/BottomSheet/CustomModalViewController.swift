//
//  CustomModalViewController.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 3.02.23.
//

import UIKit

final class CustomModalViewController: UIViewController {

    private var newElement = ""

    private var categories = Categories.names

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Стажировка в Surf"
        label.textColor = CommonColor.lightBlack
        label.font = .sfProDisplayBold(size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel = DescriptionLabel(text: "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты.",
                                                    numberOfLines: 3)


    // define lazy views


    lazy var categoriesCollectionView: UICollectionView = {
        //        let layout = TagFlowLayout()
        //        layout.estimatedItemSize = TagFlowLayout.automaticSize
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    lazy var categoriesCollectionView2: UICollectionView = {
        //        let layout = TagFlowLayout()
        //        layout.estimatedItemSize = TagFlowLayout.automaticSize
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
//                collectionView.delegate = self
//        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let joinUsLabel = DescriptionLabel(text: "Хочешь к нам?", numberOfLines: 1)
    private let description2Label = DescriptionLabel(text: "Получай стипендию, выстраивай удобный график, работай на современном железе.",
                                                     numberOfLines: 2)

    private lazy var sendRequestButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отправить заявку", for: .normal)
        button.titleLabel?.font = .sfProDisplayMedium(size: 16)
        button.backgroundColor = CommonColor.lightBlack
        button.setTitleColor(CommonColor.white, for: .normal)
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        //        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let defaultHeight: CGFloat = 330
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 50
    // keep updated with new height
    var currentContainerHeight: CGFloat = UIScreen.main.bounds.height * 0.5

    // Dynamic container constraint
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupPanGesture()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePresentContainer()
    }

    func setupView() {
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
        // Set static constraints
        NSLayoutConstraint.activate([
            // set container static constraint (trailing & leading & bottom)
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // content stackView
            //            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            //            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            //            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            //            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

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
            categoriesCollectionView2.heightAnchor.constraint(equalToConstant: 110),


            joinUsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            joinUsLabel.centerYAnchor.constraint(equalTo: sendRequestButton.centerYAnchor),

            sendRequestButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            sendRequestButton.heightAnchor.constraint(equalToConstant: 60),
            sendRequestButton.widthAnchor.constraint(equalToConstant: 219),
            sendRequestButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -58)
        ])

        // Set dynamic constraints
        // First, set container to default height
        // after panning, the height can expand
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)

        // By setting the height to default height, the container will be hide below the bottom anchor view
        // Later, will bring it up by set it to 0
        // set the constant to default height to bring it down again
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        // Activate constraints
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true

    }


    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {

        let translation = gesture.translation(in: view)
        // get drag direction
        let isDraggingDown = translation.y > 0

        // New height is based on value of dragging plus current container height
        let newHeight = currentContainerHeight - translation.y

        // Handle based on gesture state
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            if newHeight > maximumContainerHeight {
                // Keep updating the height constraint
                containerViewHeightConstraint?.constant = maximumContainerHeight
                // refresh layout
                view.layoutIfNeeded()
            }
        case .ended:

            //            if newHeight < defaultHeight {
            //                // Condition 2: If new height is below default, animate back to default
            //                animateContainerHeight(defaultHeight)
            //            }
            //            else
            if newHeight < maximumContainerHeight && isDraggingDown {
                // Condition 3: If new height is below max and going down, set to default height
                animateContainerHeight(defaultHeight)

            }
            else if newHeight > defaultHeight && !isDraggingDown {
                // Condition 4: If new height is below max and going up, set to max height at top
                animateContainerHeight(maximumContainerHeight)

                description2Label.isHidden = false
                categoriesCollectionView2.isHidden = false
            }

        default:
            break
        }
    }

    func setupPanGesture() {
        // add pan gesture recognizer to the view controller's view (the whole screen)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        // change to false to immediately listen on gesture movement
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }

    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {

            // Update container height
            self.containerViewHeightConstraint?.constant = height
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
        // Save current height
        currentContainerHeight = height

        description2Label.isHidden = true
        categoriesCollectionView2.isHidden = true
    }

    func animatePresentContainer() {
        // Update bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            // Call this to trigger refresh constraint
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
            cell.layer.cornerRadius = 12
            cell.categoriesLabel.text = categories[indexPath.row]
            return cell
        }
    }


    extension CustomModalViewController: UICollectionViewDelegate {

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            newElement = categories[indexPath.item]
            categories.remove(at: indexPath.item)
            categories.insert(newElement, at: 0)

            collectionView.moveItem(at: indexPath, to: IndexPath(item: 0, section: 0))
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
        }

        func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
            if collectionView.cellForItem(at: indexPath)?.isSelected ?? false {
                collectionView.deselectItem(at: indexPath, animated: true)
                return false
            }
            return true
        }

//        func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            let contentOffsetX = scrollView.contentOffset.x
//            let frameWidth = categoriesCollectionView.frame.width
//            let sectionLength = categoriesCollectionView.contentSize.width / CGFloat(numberOfSections(in: categoriesCollectionView))
//            let contentLength = categoriesCollectionView.contentSize.width
//            if contentOffsetX <= 0 {
//                categoriesCollectionView.contentOffset.x = sectionLength - contentOffsetX
//            } else if contentOffsetX >= contentLength - frameWidth {
//                categoriesCollectionView.contentOffset.x = contentLength - sectionLength - frameWidth
//            }
//        }
    }


