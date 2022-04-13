//
//  DefaultSettings.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 31.03.22.
//

import Foundation
import UIKit


struct DefaultSettings {
    
    static func getSettings(type: SettingsType) -> [SettingsSection] {
        switch type {
        case .mainSettings:
            return [
                SettingsSection(headerTitle: "Visual settings", footerTitle: "In these settings, you can make changes to the visual part of the application",
                                options: [SettingsOptionsType.DefaultSettingsVCCell(defaultModel: DefaultSettingsOptions(imageBackgroundColor: .green, title: "Visual Settings", settingsImage: UIImage(systemName: "iphone.homebutton.circle")))]),

                SettingsSection(headerTitle: "General settings", footerTitle: "In these settings, you can change the main elements of the program",
                                options: [SettingsOptionsType.DefaultSettingsVCCell(defaultModel: DefaultSettingsOptions(imageBackgroundColor: .purple, title: "Favorite topics", settingsImage: UIImage(systemName: "star.leadinghalf.fill")))]),

                SettingsSection(headerTitle: "Information", footerTitle: "These settings contain all information about the application, including the API",
                                options: [SettingsOptionsType.DefaultSettingsVCCell(defaultModel: DefaultSettingsOptions(imageBackgroundColor: .link, title: "info", settingsImage: UIImage(systemName: "info.circle")))])
            ]
        case .visualSettings:
            return [
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
                                                                                                                  NotificationCenter.default.post(name: .ChangeCellStyle(), object: nil)
                                               }))])
            ]
        }
    }
    
    enum SettingsType {
        case mainSettings
        case visualSettings
    }
}
