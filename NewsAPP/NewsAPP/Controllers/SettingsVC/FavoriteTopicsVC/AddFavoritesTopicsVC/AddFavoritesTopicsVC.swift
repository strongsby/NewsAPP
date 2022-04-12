//
//  AddFavoritesTopicsVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 21.03.22.
//

import UIKit


final class AddFavoritesTopicsVC: UIViewController {
    
    //MARK: - OUTLETS & CLASS PROPERTYES
    
    @IBOutlet private weak var topicTextField: UITextField! {
        didSet {
            topicTextField.becomeFirstResponder()
            topicTextField.delegate = self
        }
    }
    private var viewMode: AddFavoritesTopicsVCProtocol = AddFavoritesTopicsVCViewModel()

    //MARK: - CLASS FUNCTIONS
    
    private func bind() {
        viewMode.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    //MARK: - ACTIONS
    
    @IBAction func cancelDidTapped() {
        dismiss(animated: true, completion: nil)
    }
}


//MARK: - EXTENSION UITextFieldDelegate

extension AddFavoritesTopicsVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return viewMode.addDidTapped(topic: textField.text)
    }
}


//MARK: - EXTENSION AlertHandler

extension AddFavoritesTopicsVC: AlertHandler {}


//MARK: - EXTENSION AddFavoritesTopicsVCDelegate

extension AddFavoritesTopicsVC: AddFavoritesTopicsVCDelegate {
    
    func dismis() {
        dismiss(animated: true, completion: nil)
    }
    
    func AddFavoritesTopicsVCShowAllert(title: String?, message: String?, complition: (() -> Void)?) {
        showAlert(title: title, message: message, completion: complition)
    }
}
