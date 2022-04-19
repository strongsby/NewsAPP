//
//  CustomHeaderViewViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 6.04.22.
//

import Foundation


final class CustomHeaderViewViewModel: NSObject, CustomHeaderViewViewModelProtocol {
    
    //MARK: - CLASS PROPERTIES
    
    var delegate: CustomHeaderViewViewModelDelegate?
    var customHeaderDelegate: CustomHeaderDelegate?
    var topics: [String] = [] {
        didSet { delegate?.collectionViewReloadData() }
    }
    
    //MARK: - INIT
    
    override init() {
        super.init()
        updateTopics()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTopics), name: .AddNewTopic(), object: nil)
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
        customHeaderDelegate?.collectionViewDidSelectItemAt(indexPath: indexPath)
    }
}
