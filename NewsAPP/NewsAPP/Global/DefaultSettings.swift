//
//  DefaultSettings.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 31.03.22.
//

//import Foundation
//import UIKit
//
//// TEST
//
//struct DefaultSettings {
//    static var settings: [SettingsSection] = {
//        let array: [SettingsSection] = [
//            SettingsSection(headerTitle: "Visual settings", footerTitle: "In these settings, you can make changes to the visual part of the application",
//                            options: [ SettingsOptionsType.SwitchSettingsOptions(switchModel:
//                                    SwitchSettingsOptions(imageBackgroundColor: UIColor.green,
//                                    title: "Dark mode",
//                                    settingsImage: UIImage(systemName: "switch.2"),
//                                    switchPosition: UserDefaultService.shared.loadDarkMode,
//                                    switchChangeValue: { isOn in
//                                        guard let appDelegate = UIApplication.shared.windows.first else { return }
//            
//                                        switch isOn {
//                                        case true:
//                                            appDelegate.overrideUserInterfaceStyle = .dark
//                                            UserDefaultService.shared.saveDarkMode(bool: true)
//                                        case false:
//                                            appDelegate.overrideUserInterfaceStyle = .light
//                                            UserDefaultService.shared.saveDarkMode(bool: false)
//                                        }})),
//                                       
//                                       SettingsOptionsType.SwitchSettingsOptions(switchModel:
//                                       SwitchSettingsOptions(imageBackgroundColor: UIColor.blue,
//                                       title: "Large cell mode",
//                                       settingsImage: UIImage(systemName: "book"),
//                                       switchPosition: UserDefaultService.shared.loadLargeCellStyle,
//                                       switchChangeValue: { isOn in
//                                           UserDefaultService.shared.saveLargeCellStyle(bool: isOn)
//                                           NotificationCenter.default.post(name: NSNotification.Name("ChangeCellStyle"), object: nil)
//                                       }))]),
//            
//            SettingsSection(headerTitle: "General settings", footerTitle: "In these settings, you can change the main elements of the program",
//                            options: [SettingsOptionsType.DefaultSettingsVCCell(defaultModel:
//                                       DefaultSettingsOptions(imageBackgroundColor: .purple,
//                                                              title: "Favorite topics",
//                                                              settingsImage: UIImage(systemName: "star.leadinghalf.fill")))]),
//            
//            SettingsSection(headerTitle: "Information", footerTitle: "These settings contain all information about the application, including the API",
//                            options: [SettingsOptionsType.DefaultSettingsVCCell(defaultModel:
//                                       DefaultSettingsOptions(imageBackgroundColor: .link,
//                                                              title: "info",
//                                                              settingsImage: UIImage(systemName: "info.circle")))])
//        ]
//        return array
//    }()
//}
