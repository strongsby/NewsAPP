//
//  FavoriteTopicsVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 24.03.22.
//

import Foundation


final class FavoriteTopicsVCViewModel: NSObject, FavoriteTopicsVCViewModelProtocol {
    
    //MARK: - CLASS PROPERTYES
    
    private var userDefaultService = UserDefaultService()
    var delegate: FavoriteTopicsVCViewModelDelegate?
    var newTopics: [String] = []
    
    //MAERK: - INIT
    
    override init() {
        super.init()
        loadAllTopics()
        NotificationCenter.default.addObserver(self, selector: #selector(loadAllTopics), name: NSNotification.Name("AddNewTopic"), object: nil)
    }
    
    //MARK: - CLASS FUNCTIONS
    
    func newTopicsCount() -> Int {
        return newTopics.count
    }
    
    func tbaleViewDeleteRow(indexPath: IndexPath) {
        newTopics.remove(at: indexPath.row)
        userDefaultService.saveTopics(topics: newTopics)
        delegate?.tableViewDeletRowWithAnivation(indexPath: [indexPath])
        NotificationCenter.default.post(name: NSNotification.Name("AddNewTopic"), object: nil)
    }
    
    //MARK: - ACTIONS
    
    @objc func loadAllTopics() {
        newTopics = userDefaultService.loadTopics()
        delegate?.tableViewReloadData()
    }
}
