//
//  ViewController.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 3.02.23.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomPressed()
    }



    func showBottomPressed() {
        let bottomSheet = BottomSheetViewController()
        bottomSheet.isModalInPresentation = true//отменяет сворачивание bottom sheet
        if let sheet = bottomSheet.sheetPresentationController {
            let smallId = UISheetPresentationController.Detent.Identifier("small")
            let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallId) { context in
                return 240
            }
            sheet.detents = [smallDetent, .medium(), .large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.preferredCornerRadius = 20
            sheet.prefersEdgeAttachedInCompactHeight = true
        }
        self.present(bottomSheet, animated: true)
    }
}
