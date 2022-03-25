//
//  FavoriteTopicsVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 24.03.22.
//

import Foundation


final class FavoriteTopicsVCViewModel: NSObject, FavoriteTopicsVCViewModelProtocol {
    
    private var userDefaultService = UserDefaultService()
    var delegate: FavoriteTopicsVCViewModelDelegate?
    var newTopics: [String] = [] {
        didSet { delegate?.tableViewReloadData() }
    }
    
    override init() {
        super.init()
        loadAllTopics()
        NotificationCenter.default.addObserver(self, selector: #selector(loadAllTopics), name: NSNotification.Name("AddNewTopic"), object: nil)
    }
    
    func newTopicsCount() -> Int {
        return newTopics.count
    }
    
    func tbaleViewDeleteRow(indexPath: IndexPath) {
        newTopics.remove(at: indexPath.row)
        userDefaultService.saveTopics(topics: newTopics)
        NotificationCenter.default.post(name: NSNotification.Name("AddNewTopic"), object: nil)
    }
    
    @objc func loadAllTopics() {
        newTopics = userDefaultService.loadTopics()
    }
}
