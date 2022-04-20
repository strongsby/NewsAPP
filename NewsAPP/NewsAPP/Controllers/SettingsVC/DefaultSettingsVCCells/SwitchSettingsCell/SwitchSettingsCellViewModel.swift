//
//  SwitchSettingsCellViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 28.03.22.
//

import Foundation
import UIKit


final class  SwitchSettingsCellViewModel: NSObject,  SwitchSettingsCellViewModelProtocol {
    
    //MARK: - CLASS PROPERTIES
    
    var getLabelsTitle: String? {
        return settingsModel?.title
    }
    var getImage: UIImage? {
        return settingsModel?.settingsImage
    }
    var imageBackColor: UIColor? {
        return settingsModel?.imageBackgroundColor
    }
    var getSwitchPosition: Bool {
        guard let model = settingsModel else { return false }
        return model.switchPosition()
    }
    private var settingsModel: SwitchSettingsOptions?
    
    //MAK: - INIT
    
    convenience init(model: SwitchSettingsOptions) {
        self.init()
        settingsModel = model
    }
    
    //MARK: - CLASS FUNCTIONS
    
    func switchChangeValue(isOn: Bool) {
        settingsModel?.switchChangeValue(isOn)
    }
}
