//
//  DefaultLabel.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 6.02.23.
//

import UIKit

final class DefaultLabel: UILabel {

    init(text: String, numberOfLines: Int, font: UIFont, textColor: UIColor) {
        super.init(frame: .zero)
        self.text = text
        self.numberOfLines = numberOfLines
        self.font = font
        self.textColor = textColor
        configureTitleLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTitleLabel() {
        textAlignment = .left
        translatesAutoresizingMaskIntoConstraints = false
    }
}
