//
//  FavoriteTopicsVCCellViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 28.03.22.
//

import Foundation


final class FavoriteTopicsVCCellViewModel: NSObject, FavoriteTopicsVCCellViewModelProtocol {
    
    //MARK: - CLASS PROPERTYES
    
    private var title: String?
    
    //MARK: - INIT
    
    convenience init(titleText: String) {
        self.init()
        title = titleText
    }
    
    //MARK: - CLASS FUNCTIONS
    
    func getLableTexte() -> String? {
        return title
    }
}
