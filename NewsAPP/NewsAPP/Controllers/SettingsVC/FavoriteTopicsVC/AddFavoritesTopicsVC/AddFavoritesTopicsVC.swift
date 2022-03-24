//
//  AddFavoritesTopicsVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 21.03.22.
//

import UIKit

final class AddFavoritesTopicsVC: UIViewController {
    
    private var viewMode: AddFavoritesTopicsVCProtocol = AddFavoritesTopicsVCViewModel()
    @IBOutlet private weak var topicTextField: UITextField! {
        didSet {
            topicTextField.becomeFirstResponder()
            topicTextField.delegate = self
        }
    }
    
    private func bind() {
        viewMode.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    @IBAction func cancelDidTapped() {
        dismiss(animated: true, completion: nil)
    }
}


extension AddFavoritesTopicsVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return viewMode.addDidTapped(topic: textField.text)
    }
}


extension AddFavoritesTopicsVC: AlertHandler {}


extension AddFavoritesTopicsVC: AddFavoritesTopicsVCDelegate {
    func dismis() {
        dismiss(animated: true, completion: nil)
    }
    
    func AddFavoritesTopicsVCShowAllert(title: String?, message: String?, complition: (() -> Void)?) {
        showAlert(title: title, message: message, completion: complition)
    }
}





//
//
//
//
//import UIKit
//
//final class AddFavoritesTopicsVC: UIViewController {
//
//    let userDefaultService = UserDefaultService()
//    @IBOutlet private weak var topicTextField: UITextField! {
//        didSet {
//            topicTextField.becomeFirstResponder()
//            topicTextField.delegate = self
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    @IBAction func cancelDidTapped() {
//        dismiss(animated: true, completion: nil)
//    }
//}
//
//
//extension AddFavoritesTopicsVC: UITextFieldDelegate {
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        guard let newElement = textField.text?.capitalized else { return false }
//        var topics = userDefaultService.loadTopics()
//        guard !topics.contains(newElement) else {
//            showAlert(title: "Warning", message: "You have \(newElement) in your list! Do you really want to add it again?") {
//                topics.append(newElement)
//                self.userDefaultService.saveTopics(topics: topics)
//                NotificationCenter.default.post(name: NSNotification.Name("AddNewTopic"), object: nil)
//                self.dismiss(animated: true, completion: nil)
//            }
//            return false
//        }
//        topics.append(newElement)
//        userDefaultService.saveTopics(topics: topics)
//        dismiss(animated: true, completion: nil)
//        NotificationCenter.default.post(name: NSNotification.Name("AddNewTopic"), object: nil)
//        return true
//    }
//}
//
//
//extension AddFavoritesTopicsVC: AlertHandler {}
