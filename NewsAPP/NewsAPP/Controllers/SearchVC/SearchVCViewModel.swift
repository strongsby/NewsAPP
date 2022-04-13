//
//  SearchVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import Foundation


final class SearchVCViewModel: NSObject, SearchVCViewModelProtocol {
    
    //MARK: - CLASS PROPERTYES
    
    private var networkService = NetwokService()
    var delegate: SearchVCViewModelDelegate?
    private var serchTitle: String?
    private var newsArray: [Article] = [] {
        didSet { delegate?.tableViewReloadData() }
    }
    private var cellStyles: CellStyle = .defaultCell {
        didSet { delegate?.tableViewReloadData() }
    }
    
    //MARK: - INIT
    
    override init() {
        super.init()
        loadCellStyleFromUserDefault()
        NotificationCenter.default.addObserver(self, selector: #selector(loadCellStyleFromUserDefault), name: .ChangeCellStyle(), object: nil)
    }
    
    //MARK: - CLASSFUNCTIONS
    
    func getArticle(indexPath: IndexPath) -> Article {
        return newsArray[indexPath.row]
    }
    
    @objc func loadCellStyleFromUserDefault() {
        cellStyles = UserDefaultService.shared.loadCellStyle()
    }
    
    func cellStyle() -> CellStyle {
        return cellStyles
    }
    
    func newsArrayCount() -> Int {
        return newsArray.count
    }
    
    func getNewsWithString(title: String?) {
        guard let newsCategory = title else { return }
        serchTitle = title
        newsArray.removeAll()
        delegate?.addMessageViewPutAwayWithAnimation()
        if let delegate = delegate,  !delegate.refreshControlIsRefreshing() {
            delegate.startActivityAnimated()
        }
        networkService.serchNews(for: newsCategory) { [ weak self ] result in
            switch result {
            case .failure(let error):
                self?.delegate?.endRefreshing()
                self?.delegate?.addMessageShowWithAnimation()
                self?.delegate?.stopActivityAnimated()
                print("\(error.localizedDescription)")
                self?.delegate?.searchVCShowAllert(title: "Sorry", message: "\(error)", completion: nil)
            case .success(let news):
                self?.delegate?.endRefreshing()
                self?.delegate?.stopActivityAnimated()
                self?.newsArray = news
            }
        }
    }
    
    func refreshDidPull() {
        guard let serchTitle = serchTitle else {
            return
        }
        getNewsWithString(title: serchTitle)
    }
}





