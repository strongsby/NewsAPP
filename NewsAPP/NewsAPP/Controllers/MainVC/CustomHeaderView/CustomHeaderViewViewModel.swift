//
//  CustomHeaderViewViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 6.04.22.
//

import Foundation


final class CustomHeaderViewViewModel: NSObject, CustomHeaderViewViewModelProtocol {
    
    //MARK: - CLASS PROPERTIES
    
    var customHeaderViewDelegate: CustomHeaderViewViewModelDelegate?
    var mainVCDelegate: CustomHeaderDelegate?
    var topicsCount: Int {
        return topics.count
    }
    var topics: [String] = [] {
        didSet { customHeaderViewDelegate?.collectionViewReloadData() }
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
    
    func getTopic(indexPath: IndexPath) -> String {
        return topics[indexPath.item]
    }
    
    func collectionDidSelectItem(indexPath: IndexPath) {
        mainVCDelegate?.collectionViewDidSelectItemAt(indexPath: indexPath)
    }
}
