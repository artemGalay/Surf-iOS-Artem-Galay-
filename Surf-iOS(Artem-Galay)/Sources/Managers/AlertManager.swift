//
//  AlertManager.swift
//  Surf-iOS(Artem-Galay)
//
//  Created by Артем Галай on 8.02.23.
//

import UIKit

final class AlertManager {

private static func showBasicAlert(on vc: UIViewController, title: String, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Strings.BottomSheet.actionAlert, style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
}

extension AlertManager {

    static func showCorrectAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: Strings.BottomSheet.titleCorrectAlert, message: Strings.BottomSheet.messageCorrectAlert)
    }

    static func showWrongAlert(on vc: UIViewController) {
        self.showBasicAlert(on: vc, title: Strings.BottomSheet.titleWrongAlert, message: Strings.BottomSheet.messageWrongAlert)
    }
}
