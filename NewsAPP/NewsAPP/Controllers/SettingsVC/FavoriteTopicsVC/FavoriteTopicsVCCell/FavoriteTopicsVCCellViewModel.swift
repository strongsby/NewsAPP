//
//  FavoriteTopicsVCCellViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 28.03.22.
//

import Foundation


final class FavoriteTopicsVCCellViewModel: NSObject, FavoriteTopicsVCCellViewModelProtocol {
    
    //MARK: - CLASS PROPERTIES
    
    private var title: String?
    var getLabelsText: String? {
        return title
    }
    
    //MARK: - INIT
    
    convenience init(titleText: String) {
        self.init()
        title = titleText
    }
}
