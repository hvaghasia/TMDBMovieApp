//
//  ViewController+Helper.swift
//  MovieApp
//
//  Created by Hardik on 20/12/16.
//  Copyright © 2016 Hardik. All rights reserved.
//

import UIKit

extension UIViewController  {
    
    /**
     Display Alert on current view controller
     
     - parameter title:   The title to be displayed on Alert
     - parameter message: The message to be displayed on Alert
     */
    func showAlert(withTitle title: String?,
                   message: String?,
                   buttonTitle: String?) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
