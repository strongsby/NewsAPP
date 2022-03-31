//
//  SettingsVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import Foundation
import UIKit


final class SettingsVCViewModel: NSObject, SettingsVCViewModelProtocol {
    
    //MARK: - CLASS PROPERTYES
    
    var delegate: SettingsVCViewModelDelegate?
    var settingsArray: [SettingsSection] = {
        let array: [SettingsSection] = [
            SettingsSection(headerTitle: "Visual settings", footerTitle: "In these settings, you can change the color scheme of the program",
                            options: [ SettingsOptionsType.SwitchSettingsOptions(switchModel:
                                                                                    SwitchSettingsOptions(imageBackgroundColor: UIColor.green,
                                                                                                          title: "Dark mode",
                                                                                                          settingsImage: UIImage(systemName: "switch.2"),
                                                                                                          switchPosition: UserDefaultService.shared.loadDarkMode,
                                                                                                          switchChangeValue: { on in
                                if let appDelegate = UIApplication.shared.windows.first {
                                        switch on {
                                        case true:
                                            appDelegate.overrideUserInterfaceStyle = .dark
                                            UserDefaultService.shared.saveDarkMode(bool: true)
                                        case false:
                                            appDelegate.overrideUserInterfaceStyle = .light
                                            UserDefaultService.shared.saveDarkMode(bool: false)
                                    }
                                }
                            })),
                                       SettingsOptionsType.SwitchSettingsOptions(switchModel:
                                                                                    SwitchSettingsOptions(imageBackgroundColor: UIColor.blue,
                                                                                                          title: "Large cell mode",
                                                                                                          settingsImage: UIImage(systemName: "book"),
                                                                                                          switchPosition: UserDefaultService.shared.loadLargeCellStyle,
                                                                                                          switchChangeValue: { isOn in
                                               UserDefaultService.shared.saveLargeCellStyle(bool: isOn)
                                               NotificationCenter.default.post(name: NSNotification.Name("ChangeCellStyle"), object: nil)
                                           }))]),
            
            SettingsSection(headerTitle: "General settings", footerTitle: "In these settings, you can change the main elements of the program",
                            options: [SettingsOptionsType.DefaultSettingsVCCell(defaultModel: DefaultSettingsOptions(imageBackgroundColor: .purple, title: "Favorite topics", settingsImage: UIImage(systemName: "star.leadinghalf.fill")))]),
            
            SettingsSection(headerTitle: "Information", footerTitle: "These settings contain all information about the application, including the API",
                            options: [SettingsOptionsType.DefaultSettingsVCCell(defaultModel: DefaultSettingsOptions(imageBackgroundColor: .link, title: "info", settingsImage: UIImage(systemName: "info.circle")))])
        ]
        return array
    }()
    
    //MARK: - CLASS FUNCTIONS
    
    func settingsArrayCounr() -> Int {
        return settingsArray.count
    }
    
    func settingsArrayOptionsCount(section: Int) -> Int {
        switch section {
        case 0: return settingsArray[0].options.count
        case 1: return settingsArray[1].options.count
        case 2: return settingsArray[2].options.count
        default: return 0
        }
    }
    
    func settingsArrayTitleForFooterInSection(section: Int) -> String? {
        switch section {
        case 0: return settingsArray[0].footerTitle
        case 1: return settingsArray[1].footerTitle
        case 2: return settingsArray[2].footerTitle
        default: return nil
        }
    }
    
    func settingsArrayTitleForHeaderInSection(section: Int) -> String? {
        switch section {
        case 0: return settingsArray[0].headerTitle
        case 1: return settingsArray[1].headerTitle
        case 2: return settingsArray[2].headerTitle
        default: return nil
        }
    }
    
    func tableViewDidSelectRowAT(indexPath: IndexPath) {
        switch indexPath.section {
        case 1: delegate?.showFavoriteTopicsVC() 
        case 2: delegate?.showInfoVC()  
        default: break
        }
    }
}
