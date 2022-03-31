//
//  SavedVCCellViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 28.03.22.
//

import Foundation
import UIKit


final class SavedVCCellViewModel: NSObject, SavedVCCellViewModelProtocol {
    
    //MARK: - CLASS PROPERTYES
    
    private var coreDataNews: CoreDataNews?
    
    //MARK: - INIT
    
    convenience init(coreDataMode: CoreDataNews) {
        self.init()
        coreDataNews = coreDataMode
    }
    
    //MARK: - CLASS FUNCTIONS
    
    func getTextForLables() -> (title: String, description: String) {
        let title = coreDataNews?.title ?? ""
        let description = coreDataNews?.articleDescription ?? ""
        return (title, description)
    }
    
    func getImageLocalName() -> String? {
        guard let localName = coreDataNews?.urlToImage else { return nil }
        return localName
    }
}
