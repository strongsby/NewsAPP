//
//  AddFavoritesTopicsVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 24.03.22.
//

import Foundation


protocol AddFavoritesTopicsVCProtocol: NSObject {
    var delegate: AddFavoritesTopicsVCDelegate? { get set }
    func addDidTapped(topic: String?) -> Bool
}


final class AddFavoritesTopicsVCViewModel: NSObject, AddFavoritesTopicsVCProtocol {
    
    let userDefaultService = UserDefaultService()

    var delegate: AddFavoritesTopicsVCDelegate?
    
    func addDidTapped(topic: String?) -> Bool {
        guard let newElement = topic?.capitalized else { return false }
        var topics = userDefaultService.loadTopics()
        guard !topics.contains(newElement) else {
            delegate?.AddFavoritesTopicsVCShowAllert(title: "Warning", message: "You have \(newElement) in your list! Do you really want to add it again?") {
                topics.append(newElement)
                self.userDefaultService.saveTopics(topics: topics)
                NotificationCenter.default.post(name: NSNotification.Name("AddNewTopic"), object: nil)
                self.delegate?.dismis()
            }
            return false
        }
        topics.append(newElement)
        userDefaultService.saveTopics(topics: topics)
        delegate?.dismis()
        NotificationCenter.default.post(name: NSNotification.Name("AddNewTopic"), object: nil)
        return true
    }
}
