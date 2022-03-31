//
//  CustomSavedVCCellViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 30.03.22.
//

import Foundation
import UIKit


final class CustomSavedVCCellViewModel: NSObject, CustomSavedVCCellViewModelProtocol {
    
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
