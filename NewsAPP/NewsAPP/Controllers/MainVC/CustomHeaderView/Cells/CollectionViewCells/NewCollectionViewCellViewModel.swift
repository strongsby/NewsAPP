//
//  NewCollectionViewCellViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation


final class NewCollectionViewCellViewModel: NSObject, NewCollectionViewCellViewModelProtocol {
    
    
    //MARK: - CLASS PROPERTYES
    
    private var labelTitle: String?
    var getTitle: String? {
        return labelTitle
    }
    
    //MARK: - INIT
    
    convenience init(title: String) {
        self.init()
        labelTitle = title
    }
}
