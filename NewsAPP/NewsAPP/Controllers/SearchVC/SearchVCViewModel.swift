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
    var newsArray: [Article] = []
    var delegate: SearchVCViewModelDelegate?
    private var largeCellStyle: Bool = true {
        didSet { delegate?.tableViewReloadData() }
    }
    
    //MARK: - INIT
    
    override init() {
        super.init()
        loadCellStyleFromUserDefault()
        NotificationCenter.default.addObserver(self, selector: #selector(loadCellStyleFromUserDefault), name: NSNotification.Name("ChangeCellStyle"), object: nil)
    }
    
    //MARK: - CLASSFUNCTIONS
    
    @objc func loadCellStyleFromUserDefault() {
        largeCellStyle = UserDefaultService.shared.loadLargeCellStyle()
    }
    
    func cellStyle() -> Bool {
        return largeCellStyle
    }
    
    func newsArrayCount() -> Int {
        return newsArray.count
    }
    
    func getNewsWithString(title: String?) {
        guard let newsCategory = title else { return }
        delegate?.startAnimatedSkeletonView()
        networkService.serchNews(for: newsCategory) { [ weak self ] result in
            switch result {
            case .failure(let error):
                self?.delegate?.stopAnomatedSkeleton()
                print("\(error.localizedDescription)")
                self?.delegate?.searchVCShowAllert(title: "Sorry", message: error.localizedDescription, completion: nil)
            case .success(let news):
                self?.newsArray = news
                self?.delegate?.stopAnomatedSkeleton()
            }
        }
    }    
}





