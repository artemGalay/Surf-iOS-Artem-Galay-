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
        presentModalController()
    }

    private func presentModalController() {
        let vc = CustomModalViewController()
        vc.modalPresentationStyle = .overCurrentContext
        // Keep animated value as false
        // Custom Modal presentation animation will be handled in VC itself
        self.present(vc, animated: false)
    }
}
