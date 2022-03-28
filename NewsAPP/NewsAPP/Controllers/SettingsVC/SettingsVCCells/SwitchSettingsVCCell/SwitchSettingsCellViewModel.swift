//
//  SwitchSettingsCellViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 28.03.22.
//

import Foundation
import UIKit


final class SwitchSettingsCellViewModel: NSObject, SwitchSettingsCellViewModelProtocol {
    
    //MARK: - CLASS PROPERTYES
    
    private var userDefaultService = UserDefaultService()
    private var settingsModel: SwitchSettingsOptions?
    
    //MAK: - INIT
    
    convenience init(model: SwitchSettingsOptions) {
        self.init()
        settingsModel = model
    }
    
    func getLableTitle() -> String? {
        guard let title = settingsModel?.title else { return nil }
        return title
    }
    
    //MARK: - CLASS FUNCTIONS
    
    func getImage() -> (image: UIImage, color: UIColor)? {
        guard let image = settingsModel?.settingsImage, let backColor = settingsModel?.imageBackgroundColor else { return nil }
        return (image, backColor)
    }
    
    func getSwitchPOsition() -> Bool {
        return userDefaultService.loadDarkMode()
    }
    
    func switchChangeValue(isOn: Bool) {
        if let appDelegate = UIApplication.shared.windows.first {
                switch isOn {
                case true:
                    appDelegate.overrideUserInterfaceStyle = .dark
                    userDefaultService.saveDarkMode(bool: true)
                case false:
                    appDelegate.overrideUserInterfaceStyle = .light
                    userDefaultService.saveDarkMode(bool: false)
            }
        }
    }
}
