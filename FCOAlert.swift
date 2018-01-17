//
//  FCOAlert.swift
//  FCO Sudoku
//
//  Created by Nguyễn Tấn Phúc on 1/17/18.
//  Copyright © 2018 Nguyễn Tấn Phúc. All rights reserved.
//

import UIKit

class FCOAlert {
    class func showDoAgainAlert() {
        FCOAlert.showAlert(title: "Error", message: "please Do It Again")
    }
    
    class func showApplyAlert(message: String) {
        FCOAlert.showAlert(title: "Apply", message: message)
    }
    
    class func showNoticeAlert(message: String) {
        FCOAlert.showAlert(title: "Notice", message: message)
    }
    
    class func showOopsAlert(message: String) {
        FCOAlert.showAlert(title: "Oops", message: message)
    }
    
    class func showAlert(title: String, message: String, actions actionList:[UIAlertAction]? = nil) {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            if (actionList == nil || actionList?.count == 0) {
                let OKAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                    // ...
                }
                
                alertController.addAction(OKAction)
            } else {
                for action in actionList! {
                    alertController.addAction(action)
                }
            }
            
            topController.present(alertController, animated: true, completion: nil)
        }
    }
}
