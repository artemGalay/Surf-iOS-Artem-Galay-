//
//  UIFont+Ext.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 3.02.23.
//

import UIKit

extension UIFont {
    static func sfProDisplayBold() -> UIFont {
        UIFont(name: "SFProDisplay-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24)
    }

    static func sfProDisplayMedium16() -> UIFont {
        UIFont(name: "SFProDisplay-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16)
    }

    static func sfProDisplayMedium14() -> UIFont {
        UIFont(name: "SFProDisplay-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)
    }

    static func sfProDisplayRegular() -> UIFont {
        UIFont(name: "SFProDisplay-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
    }
}
