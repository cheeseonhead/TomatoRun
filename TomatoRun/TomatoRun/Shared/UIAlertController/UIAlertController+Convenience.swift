//
//  UIAlertController+Convenience.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 12/21/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit

extension UIAlertController {

    static func singleCancelAlert(title: String?, message: String?, cancelAction: String?, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: cancelAction, style: .cancel, handler: handler)
        alert.addAction(action)

        return alert
    }
}
