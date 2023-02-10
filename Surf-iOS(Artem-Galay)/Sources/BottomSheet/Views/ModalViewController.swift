//
//  ModalViewController.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 10.02.23.
//

import UIKit

class ModalViewController: UIViewController {

    private var isSelect = false
    private var categories = Categories.names
    private var currentContainerHeight: CGFloat = UIScreen.main.bounds.height * 0.5
    private let defaultHeight: CGFloat = 330
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 50

    // MARK: - View

    private var customView: CustomModalView? {
        guard isViewLoaded
        else {
            return nil }
        return view as? CustomModalView
    }

    // MARK: - View Life Cycle

    override func loadView() {
        view = CustomModalView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupPanGesture()


    }

    override func viewDidAppear(_ animated: Bool) {
        animatePresentContainer()
    }

    private func setupViews() {
        customView?.categoriesCollectionView.delegate = self
        customView?.categoriesCollectionView.dataSource = self
        customView?.categoriesCollectionView2.dataSource = self
        customView?.sendRequestButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
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
                customView?.containerViewHeightConstraint?.constant = maximumContainerHeight
                view.layoutIfNeeded()
            }
        case .ended:

            if newHeight < maximumContainerHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)

            }
            else if newHeight > defaultHeight && !isDraggingDown {
                animateContainerHeight(maximumContainerHeight)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.customView?.description2Label.isHidden = false
                    self.customView?.categoriesCollectionView2.isHidden = false
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
            self.customView?.containerViewHeightConstraint?.constant = height
            self.customView?.layoutIfNeeded()
        }

        currentContainerHeight = height

        self.customView?.description2Label.isHidden = true
        self.customView?.categoriesCollectionView2.isHidden = true
    }

    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.customView?.containerViewBottomConstraint?.constant = 0
            self.customView?.layoutIfNeeded()
        }
        customView?.description2Label.isHidden = true
        customView?.categoriesCollectionView2.isHidden = true
    }
}

extension ModalViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionView == customView?.categoriesCollectionView ? 2 : 1
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

extension ModalViewController: UICollectionViewDelegate {
    
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
}

//#warning("Этот метод отвечает за бесконечный скролл вправо и влево, он работает только если есть 2 секции")
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let contentOffsetX = scrollView.contentOffset.x
//        let frameWidth = categoriesCollectionView.frame.width
//        let sectionLength = categoriesCollectionView.contentSize.width / CGFloat(numberOfSections(in: categoriesCollectionView))
//        let contentLength = categoriesCollectionView.contentSize.width
//        if contentOffsetX <= 0 {
//            categoriesCollectionView.contentOffset.x = sectionLength - contentOffsetX
//        } else if contentOffsetX >= contentLength - frameWidth {
//            categoriesCollectionView.contentOffset.x = contentLength - sectionLength - frameWidth
//        }
//    }
//}

//extension CustomModalViewController: UICollectionViewDelegateFlowLayout {
//    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    //        let nameFont = UIFont.sfProDisplayMedium(size: 14)
//    //        let nameAttributes = [NSAttributedString.Key.font : nameFont as Any]
//    //        let nameWidth = categories[indexPath.item].size(withAttributes: nameAttributes).width + 50
//    //        return CGSize(width: nameWidth, height: 44)
//    //    }
//    //}
//}

