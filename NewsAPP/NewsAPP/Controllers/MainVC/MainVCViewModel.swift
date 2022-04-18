//
//  MainVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import Foundation


final class MainVCViewModel: NSObject, MainVCViewModelProtocol {
    
    //MARK: - CLASS PROPERTIES
    
    private var cellStyles: CellStyle = .defaultCell {
        didSet { delegate?.tableViewReloadData() }
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
        NotificationCenter.default.addObserver(self, selector: #selector(collectionViewDidSelectItemAt(notification:)), name: .customHeaderDidSelectItem(), object: nil)
    }
    
    //MARK: - CLASS FUNCTIONS
    
    @objc func loadCellStyleFromUserDefault() {
        cellStyles = UserDefaultService.shared.loadCellStyle()
    }
    
    @objc func collectionViewDidSelectItemAt(notification: NSNotification) {
        guard let index = notification.userInfo?["index"] as? Int else { return }
        switch index {
        case 0:
            delegate?.presentAddFavoritesTopicsVC()
        case 1:
            getLastNews()
        default:
            getNewsWithIndex(index: index)
        }
    }
    
    func getArticle(indexPath: IndexPath) -> Article {
        return articles[indexPath.row]
    }
    
    func cellStyle() -> CellStyle {
        return cellStyles
    }
    
    func articlesCount() -> Int {
        return articles.count
    }
    
    func getLastNews() {
        articles.removeAll()
        searchIndex = nil
        delegate?.addMessageViewPutAwayWithAnimation()
        if let delegate = delegate,  !delegate.refreshControlIsRefreshing() {
            delegate.startActivityAnimated()
        }
        networkService.getLatsNews { [ weak self ] result in
            self?.delegate?.endRefreshing()
            self?.delegate?.stopActivityAnimated()
            switch result {
            case .failure(let error):
                self?.delegate?.addMessageShowWithAnimation()
                self?.delegate?.mainVCShowAlert(title: "Sorry", message: "\(error)", completion: nil)
                print(error)
            case .success(let news):
                self?.articles = news
            }
        }
    }
    
    func getNewsWithIndex(index: Int) {
        searchIndex = index
        articles.removeAll()
        delegate?.addMessageViewPutAwayWithAnimation()
        if let delegate = delegate,  !delegate.refreshControlIsRefreshing() {
            delegate.startActivityAnimated()
        } 
        let needTopic = UserDefaultService.shared.loadTopics()[index - 2]
        networkService.searchNews(for: needTopic) { [ weak self ] result in
            self?.delegate?.endRefreshing()
            self?.delegate?.stopActivityAnimated()
            switch result {
            case .failure(let error):
                self?.delegate?.addMessageShowWithAnimation()
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


