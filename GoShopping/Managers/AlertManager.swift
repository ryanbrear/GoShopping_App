//
//  AlertManager.swift
//  GoShopping
//
//  Created by Ryan Brear on 2019/04/19.
//  Copyright © 2019 Ryan Brear. All rights reserved.
//

import UIKit

internal struct AlertManager {
    
    func showAlertWithOneAction(view: UIViewController, title: String?, message: String?, firstActionTitle: String?, firstActionCompletion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let firstAction = UIAlertAction(title: firstActionTitle, style: .default, handler: firstActionCompletion)
        alert.addAction(firstAction)
        view.present(alert, animated: true, completion: nil)
    }
    
    
    func showAlertWithTwoActions(view: UIViewController, title: String?, message: String?, firstActionTitle: String?, firstStyle: UIAlertAction.Style, firstActionCompletion: ((UIAlertAction) -> Void)?, secondActionTitle: String?, secondStyle: UIAlertAction.Style, secondActionCompletion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let firstAction = UIAlertAction(title: firstActionTitle, style: firstStyle, handler: firstActionCompletion)
        let secondAction = UIAlertAction(title: secondActionTitle, style: secondStyle, handler: secondActionCompletion)
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        view.present(alert, animated: true, completion: nil)
    }
}
