//
//  Allert+Handler.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 15.03.22.
//

import UIKit


protocol AlertHandler where Self: UIViewController { }

extension AlertHandler {
    
    func showAlert(title: String?, message: String?, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        if let completion = completion {
            let completionAction = UIAlertAction(title: "OK", style: .default) { _ in
                completion()
            }
            alert.addAction(completionAction)
        }

        present(alert, animated: true, completion: nil)
    }
}
