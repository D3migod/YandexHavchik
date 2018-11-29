//
//  UIViewController+showAlert.swift
//  YandexHavchik
//
//  Created by Bulat Galiev on 27/11/2018.
//  Copyright © 2018 Булат Галиев. All rights reserved.
//

import UIKit

fileprivate struct Constants {
    static let ok = "OK"
}

extension UIViewController {
    func showAlert(title: String? = nil, message : String? = nil, okAction: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.ok, style: UIAlertAction.Style.default, handler: okAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
