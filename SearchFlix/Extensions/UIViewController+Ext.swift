//
//  UIViewController+Ext.swift
//  SearchFlix
//
//  Created by Mine Rala on 20.02.2025.
//

import UIKit

import UIKit

extension UIViewController {

    func showAlert(title: String = "Error", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // Ok butonu ekliyoruz
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)

        // Alert'i ekranda gösteriyoruz
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
