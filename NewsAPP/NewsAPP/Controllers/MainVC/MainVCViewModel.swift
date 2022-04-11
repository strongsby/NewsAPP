//
//  MainVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import Foundation


final class MainVCViewModel: NSObject, MainVCViewModelProtocol {
    
    //MARK: - CLASS PROPERTYES
    
    private var largeCellStyle: Bool = false {
        didSet { delegate?.tableViewReloadData() }
    }
    private var netwokService = NetwokService()
    var delegate: MainVCViewModelDelegate?
    var articles: [Article] = [] {
        didSet { delegate?.tableViewReloadData() }
    }
    
    //MARK: - INIT
    
    override init() {
        super.init()
        loadCellStyleFromUserDefault()
        NotificationCenter.default.addObserver(self, selector: #selector(loadCellStyleFromUserDefault), name: NSNotification.Name("ChangeCellStyle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(collectionViewDidSelectItemAt(notification:)), name: NSNotification.Name("CustomHeaderDidSelectItem"), object: nil)
    }
    
    //MARK: - CLASS FUNCTIONS
    
    @objc func loadCellStyleFromUserDefault() {
        largeCellStyle = UserDefaultService.shared.loadLargeCellStyle()
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
    
    func cellStyle() -> Bool {
        return largeCellStyle
    }
    
    func articlesCount() -> Int {
        return articles.count
    }
    
    func getLastNews() {
        articles.removeAll()
        delegate?.startActivityAnimated()
        delegate?.addMessageViewPutAwayWithAnimation()
        netwokService.getLatsNews { [ weak self ] result in
            switch result {
            case .failure(let error):
                self?.delegate?.stopActivityAnimated()
                self?.delegate?.addMessageShowWithAnimation()
                self?.delegate?.mainVCShowAllert(title: "Sorry", message: "\(error)", completion: nil)
                print(error)
            case .success(let news):
                self?.delegate?.stopActivityAnimated()
                if news.isEmpty {
                    self?.delegate?.addMessageShowWithAnimation()
                }
                self?.delegate?.stopAnimatedSkeletonView()
                self?.articles = news
            }
        }
    }
    
    func getNewsWithIndex(index: Int) {
        articles.removeAll()
        delegate?.addMessageViewPutAwayWithAnimation()
        delegate?.startActivityAnimated()
        let needTopic = UserDefaultService.shared.loadTopics()[index - 2]
        netwokService.serchNews(for: needTopic) { [ weak self ] result in
            switch result {
            case .failure(let error):
                self?.delegate?.stopActivityAnimated()
                self?.delegate?.addMessageShowWithAnimation()
                self?.delegate?.mainVCShowAllert(title: "Sorry", message: "\(error)", completion: nil)
            case .success(let articles):
                self?.delegate?.stopActivityAnimated()
                if articles.isEmpty {
                    self?.delegate?.addMessageShowWithAnimation()
                }
                self?.articles = articles
            }
        }
    }
}


