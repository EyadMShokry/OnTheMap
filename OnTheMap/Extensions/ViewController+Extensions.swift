//
//  ViewController+Extensions.swift
//  OnTheMap
//
//  Created by Eyad Shokry on 2/5/19.
//  Copyright © 2019 Eyad Shokry. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    
    //showInfo()
    func raiseAlertView(withTitle: String = "Error", withMessage: String, action: (() -> Void)? = nil) {
        performUIUpdatesOnMain {
            let alertController = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: {alertAction in action?()})
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
        }
    }
    
    func showConfermationAlert(withMessage: String, actionTitle: String, action: @escaping () -> Void) {
        performUIUpdatesOnMain {
            let alertController = UIAlertController(title: nil, message: withMessage, preferredStyle: .alert)
            let alertAction1 = UIAlertAction(title: "Cancel", style: .cancel)
            let alertAction2 = UIAlertAction(title: actionTitle, style: .destructive, handler: {
                (alertAction) in
                action()
            })
            alertController.addAction(alertAction1)
            alertController.addAction(alertAction2)
            
            self.present(alertController, animated: true)
        }
    }
    
    
    func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
        DispatchQueue.main.async {
            updates()
        }
    }
    
    func enableUI(views: UIControl..., enable: Bool) {
        performUIUpdatesOnMain {
            for view in views {
                view.isEnabled = enable
            }
        }
    }
    
    func openWithSafari(_ url: String) {
        guard let url = URL(string: url), UIApplication.shared.canOpenURL(url) else {
            raiseAlertView(withMessage: "Invalid link.")
            return
        }
        UIApplication.shared.open(url, options: [:])
    }

}
