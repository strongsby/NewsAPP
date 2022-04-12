//
//  AddFavoritesTopicsVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 24.03.22.
//

import Foundation


final class AddFavoritesTopicsVCViewModel: NSObject, AddFavoritesTopicsVCProtocol {
    
    var delegate: AddFavoritesTopicsVCDelegate?
    
    func addDidTapped(topic: String?) -> Bool {
        guard let newElement = topic?.capitalized else { return false }
        var topics = UserDefaultService.shared.loadTopics()
        guard !topics.contains(newElement) else {
            delegate?.AddFavoritesTopicsVCShowAllert(title: "Warning", message: "You have \(newElement) in your list! Do you really want to add it again?") {
                topics.append(newElement)
                UserDefaultService.shared.saveTopics(topics: topics)
                NotificationCenter.default.post(name: .AddNewTopic(), object: nil)
                self.delegate?.dismis()
            }
            return false
        }
        topics.append(newElement)
        UserDefaultService.shared.saveTopics(topics: topics)
        delegate?.dismis()
        NotificationCenter.default.post(name: .AddNewTopic(), object: nil)
        return true
    }
}
