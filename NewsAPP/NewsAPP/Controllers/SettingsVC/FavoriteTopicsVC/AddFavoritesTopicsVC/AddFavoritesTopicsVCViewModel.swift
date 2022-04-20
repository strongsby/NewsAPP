//
//  AddFavoritesTopicsVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 24.03.22.
//

import Foundation


final class AddFavoritesTopicsVCViewModel: NSObject, AddFavoritesTopicsVCProtocol {
    
    //MARK: - CLASS PROPERTIES
    
    var delegate: AddFavoritesTopicsVCDelegate?
    
    //MARK: - CLASS FUNCS
    
    private func addNewTopic(_ topics: inout [String], _ newElement: String) {
        topics.append(newElement)
        UserDefaultService.shared.saveTopics(topics: topics)
        NotificationCenter.default.post(name: .AddNewTopic(), object: nil)
        delegate?.dismiss()
    }
    
    func addDidTapped(topic: String?) -> Bool {
        guard let newElement = topic?.capitalized else { return false }
        var topics = UserDefaultService.shared.loadTopics()
        guard !topics.contains(newElement) else {
            delegate?.AddFavoritesTopicsVCShowAlert(title: "Warning", message: "You have \(newElement) in your list! Do you really want to add it again?") {
                self.addNewTopic(&topics, newElement)
            }
            return false
        }
        addNewTopic(&topics, newElement)
        return true
    }
}
