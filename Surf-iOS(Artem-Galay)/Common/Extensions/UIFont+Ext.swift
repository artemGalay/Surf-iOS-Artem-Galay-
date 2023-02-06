//
//  UIFont+Ext.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 3.02.23.
//

import UIKit

extension UIFont {
    static func sfProDisplayBold(size: CGFloat) -> UIFont {
        UIFont(name: "SFProDisplay-Bold", size: size) ?? UIFont.systemFont(ofSize: 24)
    }

    static func sfProDisplayMedium(size: CGFloat) -> UIFont {
        UIFont(name: "SFProDisplay-Medium", size: size) ?? UIFont.systemFont(ofSize: 16)
    }
    static func sfProDisplayRegular(size: CGFloat) -> UIFont {
        UIFont(name: "SFProDisplay-Regular", size: size) ?? UIFont.systemFont(ofSize: 14)
    }
}
