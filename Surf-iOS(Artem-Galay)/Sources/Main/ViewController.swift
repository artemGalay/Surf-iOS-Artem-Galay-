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
        self.present(vc, animated: false)
    }
}
