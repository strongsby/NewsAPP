//
//  VisualSettingsVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 11.04.22.
//

import Foundation
import UIKit


final class VisualSettingsVCViewModel:  NSObject, VisualSettingsVCViewModelProyocol {
    
    //MARK: - CLASS PROPERTYES
    
    var settingsArray: [SettingsSection] = [
        SettingsSection(headerTitle: nil, footerTitle: "In these settings, you can change the color scheme of the application as well as the style of displaying news.",
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
                                       }))])
    ]
    
    //MARK: - CLASS FUNCTIONS
    
    func getSettingsType(indexPath: IndexPath) -> SettingsOptionsType {
        return settingsArray[indexPath.section].options[indexPath.row]
    }
    
    func settingsArrayCounr() -> Int {
        return settingsArray.count
    }
    
    func settingsArrayOptionsCount(section: Int) -> Int {
        return settingsArray[section].options.count
    }
    
    func settingsArrayTitleForFooterInSection(section: Int) -> String? {
        return settingsArray[section].footerTitle
    }
    
    func settingsArrayTitleForHeaderInSection(section: Int) -> String? {
        return settingsArray[section].headerTitle
    }
}
