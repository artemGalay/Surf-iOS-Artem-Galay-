//
//  ViewController.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 3.02.23.
//

import UIKit

class ViewController: UIViewController {

    private let customView = View()

    override func loadView() {
        super.loadView()
        view = customView
        view.addBackground()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
