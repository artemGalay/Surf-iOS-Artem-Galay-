//
//  CustomModalViewController.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 3.02.23.
//

import UIKit

final class CustomModalViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Стажировка в Surf"
        label.textColor = CommonColor.lightBlack
        label.font = UIFont.sfProDisplayBold24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты."
        label.textColor = CommonColor.gray
        label.numberOfLines = 3
        label.font = UIFont.sfProDisplayRegular14()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // define lazy views

    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 12.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var sendRequestButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить заявку", for: .normal)
        button.backgroundColor = CommonColor.lightBlack
        button.setTitleColor(CommonColor.white, for: .normal)
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
//        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let defaultHeight: CGFloat = 276
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

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        animatePresentContainer()
//    }

    func setupView() {
        view.backgroundColor = .clear
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(sendRequestButton)
    }

    func setupConstraints() {
        // Set static constraints
        NSLayoutConstraint.activate([
            // set container static constraint (trailing & leading & bottom)
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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

            sendRequestButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -58),
            sendRequestButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            sendRequestButton.heightAnchor.constraint(equalToConstant: 60),
            sendRequestButton.widthAnchor.constraint(equalToConstant: 219)
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
        // drag to top will be minus value and vice versa
        print("Pan gesture y offset: \(translation.y)")

        // get drag direction
        let isDraggingDown = translation.y > 0
        print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")

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

            if newHeight < defaultHeight {
                // Condition 2: If new height is below default, animate back to default
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                // Condition 3: If new height is below max and going down, set to default height
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                // Condition 4: If new height is below max and going up, set to max height at top
                animateContainerHeight(maximumContainerHeight)
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
//        currentContainerHeight = height
    }

//    func animatePresentContainer() {
//        // Update bottom constraint in animation block
//        UIView.animate(withDuration: 0.3) {
//            self.containerViewBottomConstraint?.constant = 0
//            // Call this to trigger refresh constraint
//            self.view.layoutIfNeeded()
//        }
//    }
}
