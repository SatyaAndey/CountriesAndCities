//
//  UIViewController+Extensions.swift
//  CountriesAndCities
//
//  Created by Satya on 01/02/24.
//  Copyright © 2024 Satya. All rights reserved.
//

import UIKit

extension UIViewController {
    /// This method used to show alert popup with message.
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: APP_ALERT_OK, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
