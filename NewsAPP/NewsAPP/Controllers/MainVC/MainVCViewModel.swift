//
//  MainVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import Foundation


protocol MainVCViewModelProtocol: NSObject {
    var articles: [Article] { get set }
    var topics: [String] { get set }
    var delegate: MainVCViewModelDelegate? { get set }
    func collectionViewDidSelectItemAt(indexPath: IndexPath)
    func getLastNews()
    func getNewsWithIndex(index: Int)
    func articlesCount() -> Int
    func topicsCount() -> Int
}


final class MainVCViewModel: NSObject, MainVCViewModelProtocol {
    
    var delegate: MainVCViewModelDelegate?
    private var netwokService = NetwokService()
    private var userDefaultService = UserDefaultService()
    
    var articles: [Article] = []
    
    var topics: [String] = [] {
        didSet {
            delegate?.collectionViewReloadData()
        }
    }
    
    func getLastNews() {
        delegate?.startAnimatedSkeletonView()
        netwokService.getLatsNews { [ weak self ] result in
            switch result {
            case .failure(let error):
                self?.delegate?.stopAnimatedSkeletonView()
                self?.delegate?.mainVCShowAllert(title: "Sorry", message: "\(error.localizedDescription)", completion: nil)
                print(error)
            case .success(let news):
                self?.delegate?.stopAnimatedSkeletonView()
                self?.articles = news
            }
        }
    }
    
    func getNewsWithIndex(index: Int) {
        delegate?.startAnimatedSkeletonView()
        let needTopic = topics[index]
        netwokService.serchNews(for: needTopic) { [ weak self ] result in
            switch result {
            case .failure(let error):
                self?.delegate?.stopAnimatedSkeletonView()
                self?.delegate?.mainVCShowAllert(title: "Sorry", message: error.localizedDescription, completion: nil)
            case .success(let articles):
                self?.delegate?.stopAnimatedSkeletonView()
                self?.articles = articles
            }
        }
    }
    
    
    func collectionViewDidSelectItemAt(indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            delegate?.presentAddFavoritesTopicsVC()
        case 1:
            getLastNews()
        default:
            getNewsWithIndex(index: indexPath.item)
        }
    }
    
    func articlesCount() -> Int {
        return articles.count
    }
    
    func topicsCount() -> Int {
        return topics.count
    }
    
    override init() {
        super.init()
        updateTopics()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTopics), name: NSNotification.Name("AddNewTopic"), object: nil)
    }
    
    @objc private func updateTopics() {
        topics = ["+", "Last"] + userDefaultService.loadTopics()
    }
}
