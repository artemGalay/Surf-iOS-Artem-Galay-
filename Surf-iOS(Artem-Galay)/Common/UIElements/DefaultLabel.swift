//
//  DefaultLabel.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 6.02.23.
//

import UIKit

final class DefaultLabel: UILabel {

    init(text: String, numberOfLines: Int) {
        super.init(frame: .zero)
        self.text = text
        self.numberOfLines = numberOfLines
        configureTitleLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTitleLabel() {
        textColor = CommonColor.gray
        font = .sfProDisplayRegular(size: 14)
        textAlignment = .left
        translatesAutoresizingMaskIntoConstraints = false
    }
}
