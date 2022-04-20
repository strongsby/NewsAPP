//
//  DefaultSettingsVCCellViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 28.03.22.
//

import Foundation
import UIKit


final class DefaultSettingsVCCellViewModel: NSObject, DefaultSettingsVCCellViewModelProtocol {
    
    //MARK: - CLASS PROPERTIES
    
    private var settingsModel: DefaultSettingsOptions?
    var getLabelText: String? {
        return settingsModel?.title
    }
    
    var getImage: UIImage? {
        return settingsModel?.settingsImage
    }
    
    var imageBackColor: UIColor? {
        return settingsModel?.imageBackgroundColor
    }
    //MARK: - INIT
    
    convenience init(model: DefaultSettingsOptions) {
        self.init()
        settingsModel = model
    }
}
