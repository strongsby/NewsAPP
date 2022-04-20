//
//  FavoriteTopicsVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 24.03.22.
//

import Foundation


final class FavoriteTopicsVCViewModel: NSObject, FavoriteTopicsVCViewModelProtocol {
    
    //MARK: - CLASS PROPERTIES
    
    var delegate: FavoriteTopicsVCViewModelDelegate? {
        didSet { checkNewsTopic() }
    }
    var newTopicsCount: Int {
        return newTopics.count
    }
    private var newTopics: [String] = [] {
        didSet { checkNewsTopic() }
    }
    
    //MAERK: - INIT
    
    override init() {
        super.init()
        loadAllTopics()
        NotificationCenter.default.addObserver(self, selector: #selector(loadAllTopics), name: .AddNewTopic(), object: nil)
    }
    
    //MARK: - CLASS FUNCTIONS
    
    func getTopic(indexPath: IndexPath) -> String {
        return newTopics[indexPath.row]
    }
    
    private func checkNewsTopic() {
        switch newTopics.isEmpty {
        case true: delegate?.addMessageShowWithAnimation()
        case false: delegate?.addMessageViewPutAwayWithAnimation()
        }
    }
    
    func tableViewDeleteRow(indexPath: IndexPath) {
        newTopics.remove(at: indexPath.row)
        UserDefaultService.shared.saveTopics(topics: newTopics)
        delegate?.tableViewDeleteRowWithAnimation(indexPath: [indexPath])
        NotificationCenter.default.post(name: NSNotification.Name("AddNewTopic"), object: nil)
    }
    
    //MARK: - ACTIONS
    
    @objc func loadAllTopics() {
        newTopics = UserDefaultService.shared.loadTopics()
        delegate?.tableViewReloadData()
    }
}
