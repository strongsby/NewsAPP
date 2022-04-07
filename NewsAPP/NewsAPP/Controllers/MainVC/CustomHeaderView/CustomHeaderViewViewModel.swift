//
//  CustomHeaderViewViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 6.04.22.
//

import Foundation


final class CustomHeaderViewViewModel: NSObject, CustomHeaderViewViewModelProtocol {
    
    //MARK: - CLASS PROPERTYES
    
    var delegate: CustomHeaderViewViewModelDelegate?
    var topics: [String] = [] {
        didSet { delegate?.collectionViewReloadData() }
    }
    
    //MARK: - INIT
    
    override init() {
        super.init()
        updateTopics()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTopics), name: NSNotification.Name("AddNewTopic"), object: nil)
    }
    
    //MARK: - CLASS FUNCTIONS
    
    @objc private func updateTopics() {
        topics = ["+", "Last"] + UserDefaultService.shared.loadTopics()
    }
    
    func topicsCount() -> Int {
        return topics.count
    }
    
    func getTopic(indexPath: IndexPath) -> String {
        return topics[indexPath.item]
    }
    
    func collectionDidSelectItem(indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("CustomHeaderDidSelectItem"), object: nil, userInfo: ["index" : indexPath.item])

    }
}
