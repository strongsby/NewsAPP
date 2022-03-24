//
//  SearchVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import Foundation


protocol SearchVCViewModelProtocol: NSObject {
    var newsArray: [Article] { get set }
    var delegate: SearchVCViewModelDelegate? { get set }
    func getNewsWithString(title: String?)
    func newsArrayCount() -> Int
}


final class SearchVCViewModel: NSObject, SearchVCViewModelProtocol {
    
    private var networkService = NetwokService()
    var newsArray: [Article] = []
    
    var delegate: SearchVCViewModelDelegate?
    
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
                //self?.delegate?.clearSearchBar()
            }
        }
    }    
}
