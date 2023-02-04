//
//  ViewController.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 3.02.23.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomPressed()
    }

    private func showBottomPressed() {
        let bottomSheet = BottomSheetViewController()
        bottomSheet.isModalInPresentation = true//отменяет сворачивание bottom sheet

        guard let sheet = bottomSheet.sheetPresentationController else { return }
        let smallId = UISheetPresentationController.Detent.Identifier("small")
        let small = UISheetPresentationController.Detent.custom(identifier: smallId) { context in 240 }
        sheet.detents = [small, .medium(), .large()]
        sheet.prefersScrollingExpandsWhenScrolledToEdge = false//приоретет на скролл
//        sheet.prefersGrabberVisible = true//граббер
//        sheet.largestUndimmedDetentIdentifier = .medium
        sheet.preferredCornerRadius = 20
        sheet.prefersEdgeAttachedInCompactHeight = true//работа в портретном режиме
        present(bottomSheet, animated: true)
    }
}
