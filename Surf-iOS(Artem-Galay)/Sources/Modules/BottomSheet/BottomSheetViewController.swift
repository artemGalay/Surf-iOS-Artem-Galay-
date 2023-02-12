//
//  BottomSheetViewController.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 10.02.23.
//

import UIKit

final class BottomSheetViewController: UIViewController {

    // MARK: - Properties

    private let presenter = BottomSheetPresenter()

    private var isSelect = false
    private var previousIndex: IndexPath?
    private var currentContainerHeight: CGFloat = UIScreen.main.bounds.height * 0.5
    private let defaultHeight: CGFloat = 330
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 50

    // MARK: - View

    private let customView = BottomSheetView()

    // MARK: - Life Cycle

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
        setupPanGesture()
    }

    override func viewDidAppear(_ animated: Bool) {
        animatePresentContainer()

        // Set the initial element for carouselCollectionView
        let indexPath = IndexPath(item: presenter.getNumberOfItemsInfiniteCarousel() / 2, section: 0)
        customView.carouselCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }

    // MARK: - Configuration
    private func setupConfiguration() {
        customView.carouselCollectionView.dataSource = self
        customView.carouselCollectionView.delegate = self
        customView.doubleCarouselCollectionView.dataSource = self
        customView.doubleCarouselCollectionView.delegate = self
        customView.sendRequestButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        !isSelect ? AlertManager.showWrongAlert(on: self) : AlertManager.showCorrectAlert(on: self)
    }

    // MARK: - BottomSheet Configuration
    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {

        let translation = gesture.translation(in: view)
        let isDraggingDown = translation.y > 0
        let newHeight = currentContainerHeight - translation.y

        switch gesture.state {
        case .changed:
            if newHeight > maximumContainerHeight {
                animateContainerHeight(maximumContainerHeight)
            }
        case .ended:
            if newHeight < maximumContainerHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                UIView.animate(withDuration: 0.3, delay: 0.1) {
                    self.customView.containerViewHeightConstraint?.constant = self.maximumContainerHeight
                    self.customView.layoutIfNeeded()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.customView.awardLabel.isHidden = false
                    self.customView.doubleCarouselCollectionView.isHidden = false
                }
            }
        default:
            break
        }
    }

    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }

    private func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.customView.containerViewHeightConstraint?.constant = height
            self.customView.layoutIfNeeded()
        }
        currentContainerHeight = height

        self.customView.awardLabel.isHidden = true
        self.customView.doubleCarouselCollectionView.isHidden = true
    }

    private func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.customView.containerViewBottomConstraint?.constant = 0
            self.customView.layoutIfNeeded()
        }

        customView.awardLabel.isHidden = true
        customView.doubleCarouselCollectionView.isHidden = true
    }
}

// MARK: - UICollectionViewDataSource
extension BottomSheetViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == customView.carouselCollectionView ? presenter.getNumberOfItemsInfiniteCarousel() : presenter.getNumberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoriesCollectionViewCell.identifier,
            for: indexPath) as? CategoriesCollectionViewCell else { return UICollectionViewCell() }

        cell.categoriesLabel.text = presenter.getCategoriesText(for: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDataSource
extension BottomSheetViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Deselect all previous items, if any
        if collectionView == customView.carouselCollectionView {
            if let previousIndex = previousIndex {
                for item in 0...presenter.getNumberOfItemsInfiniteCarousel() {
                    if (item % presenter.getNumberOfItems()) == (
                        previousIndex.item % presenter.getNumberOfItems()) {
                        let indexPath = IndexPath(item: item, section: 0)
                        collectionView.deselectItem(at: indexPath, animated: true)
                    }
                }
            }

            // Select all new elements
            for item in 0...presenter.getNumberOfItemsInfiniteCarousel() {
                if (item % presenter.getNumberOfItems()) == (indexPath.item % presenter.getNumberOfItems()) {
                    let indexPath = IndexPath(item: item, section: 0)
                    collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                    isSelect = true
                }
            }
            previousIndex = indexPath
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }

        if collectionView == customView.doubleCarouselCollectionView {
            isSelect = true
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // Deselect item when scroll item is select
        if collectionView == customView.carouselCollectionView {
            if let previousIndex = previousIndex {
                for item in 0...presenter.getNumberOfItemsInfiniteCarousel() {
                    if (item % presenter.getNumberOfItems()) == (previousIndex.item % presenter.getNumberOfItems()) {
                        let indexPath = IndexPath(item: item, section: 0)
                        collectionView.deselectItem(at: indexPath, animated: true)
                        isSelect = false
                    }
                }
            }
        }

        if collectionView == customView.doubleCarouselCollectionView {
            isSelect = false
        }
    }
}
