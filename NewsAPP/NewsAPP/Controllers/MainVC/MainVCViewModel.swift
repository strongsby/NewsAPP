//
//  MainVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import Foundation


final class MainVCViewModel: NSObject, MainVCViewModelProtocol {
    
    //MARK: - CLASS PROPERTIES
    
    var cellStyle: CellStyle = .defaultCell {
        didSet { delegate?.tableViewReloadData() }
    }
    var articlesCount: Int {
        return articles.count
    }
    private var networkService = NetworkService()
    private var searchIndex: Int?
    var delegate: MainVCViewModelDelegate?
    private var articles: [Article] = [] {
        didSet { delegate?.tableViewReloadData() }
    }
    
    //MARK: - INIT
    
    override init() {
        super.init()
        loadCellStyleFromUserDefault()
        NotificationCenter.default.addObserver(self, selector: #selector(loadCellStyleFromUserDefault), name: .ChangeCellStyle(), object: nil)
    }
    
    //MARK: - CLASS FUNCTIONS
    
    @objc func loadCellStyleFromUserDefault() {
        cellStyle = UserDefaultService.shared.loadCellStyle()
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
    
    func getArticle(indexPath: IndexPath) -> Article {
        return articles[indexPath.row]
    }
    
    func getLastNews() {
        articles.removeAll()
        searchIndex = nil
        networkService.getLatsNews { [ weak self ] result in
            switch result {
            case .failure(let error):
                self?.delegate?.mainVCShowAlert(title: "Sorry", message: "\(error)", completion: nil)
            case .success(let news):
                self?.articles = news
            }
        }
    }
    
    func getNewsWithIndex(index: Int) {
        searchIndex = index
        articles.removeAll()
        let topics = ["+", "Last"] + UserDefaultService.shared.loadTopics()
        networkService.searchNews(for: topics[index]) { [ weak self ] result in
            switch result {
            case .failure(let error):
                self?.delegate?.mainVCShowAlert(title: "Sorry", message: "\(error)", completion: nil)
            case .success(let articles):
                self?.articles = articles
            }
        }
    }
    
    func refreshDidPull() {
        guard let index = searchIndex else {
            getLastNews()
            return
        }
        getNewsWithIndex(index: index)
    }
}


