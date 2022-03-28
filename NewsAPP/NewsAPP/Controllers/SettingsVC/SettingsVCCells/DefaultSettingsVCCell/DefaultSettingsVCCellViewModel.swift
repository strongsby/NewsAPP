//
//  DefaultSettingsVCCellViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 28.03.22.
//

import Foundation
import UIKit


final class DefaultSettingsVCCellViewModel: NSObject, DefaultSettingsVCCellViewModelProtocol {
    
    //MARK: - CLASS PROPERTYES
    
    private var settingsModel: DefaultSettingsOptions?
    
    //MARK: - INIT
    
    convenience init(model: DefaultSettingsOptions) {
        self.init()
        settingsModel = model
    }
    
    //MARK: - CLASS FUNCTIONS
    
    func getImage() -> (image: UIImage, color: UIColor)? {
        guard let image = settingsModel?.settingsImage, let color = settingsModel?.imageBackgroundColor else { return nil }
        return (image, color)
    }
    
    func getLabelText() -> String? {
        guard let title = settingsModel?.title else { return nil }
        return title
    }
    
    
}
