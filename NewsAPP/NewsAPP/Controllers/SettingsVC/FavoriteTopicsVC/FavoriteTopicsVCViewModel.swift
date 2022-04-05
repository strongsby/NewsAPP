//
//  FavoriteTopicsVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 24.03.22.
//

import Foundation


final class FavoriteTopicsVCViewModel: NSObject, FavoriteTopicsVCViewModelProtocol {
    
    //MARK: - CLASS PROPERTYES
    
    var delegate: FavoriteTopicsVCViewModelDelegate? {
        didSet { checkNewTopic() }
    }
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
    
    private func checkNewTopic() {
        switch newTopics.isEmpty {
        case true: delegate?.addMessageShowWithAnimation()
        case false: delegate?.addMessageViewPutAwayWithAnimation()
        }
    }
    
    func tbaleViewDeleteRow(indexPath: IndexPath) {
        newTopics.remove(at: indexPath.row)
        UserDefaultService.shared.saveTopics(topics: newTopics)
        delegate?.tableViewDeletRowWithAnivation(indexPath: [indexPath])
        NotificationCenter.default.post(name: NSNotification.Name("AddNewTopic"), object: nil)
    }
    
    //MARK: - ACTIONS
    
    @objc func loadAllTopics() {
        newTopics = UserDefaultService.shared.loadTopics()
        delegate?.tableViewReloadData()
        checkNewTopic()
    }
}
