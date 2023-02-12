//
//  String.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 12.02.23.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
