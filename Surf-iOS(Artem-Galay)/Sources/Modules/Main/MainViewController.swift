//
//  MainViewController.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 3.02.23.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentModalController()
    }

    // MARK: - Private methods
    private func presentModalController() {
        let viewController = BottomSheetViewController()
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: false)
    }
}
