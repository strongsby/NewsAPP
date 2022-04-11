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
    var settingsArray: [SettingsSection] = [
        SettingsSection(headerTitle: "Visual settings", footerTitle: "In these settings, you can make changes to the visual part of the application",
                        options: [SettingsOptionsType.DefaultSettingsVCCell(defaultModel: DefaultSettingsOptions(imageBackgroundColor: .green, title: "Visual Settings", settingsImage: UIImage(systemName: "iphone.homebutton.circle")))]),

        SettingsSection(headerTitle: "General settings", footerTitle: "In these settings, you can change the main elements of the program",
                        options: [SettingsOptionsType.DefaultSettingsVCCell(defaultModel: DefaultSettingsOptions(imageBackgroundColor: .purple, title: "Favorite topics", settingsImage: UIImage(systemName: "star.leadinghalf.fill")))]),

        SettingsSection(headerTitle: "Information", footerTitle: "These settings contain all information about the application, including the API",
                        options: [SettingsOptionsType.DefaultSettingsVCCell(defaultModel: DefaultSettingsOptions(imageBackgroundColor: .link, title: "info", settingsImage: UIImage(systemName: "info.circle")))])
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
    
    func tableViewDidSelectRowAT(indexPath: IndexPath) {
        switch indexPath.section {
        case 0: delegate?.showSettingsVCWithMode()
        case 1: delegate?.showFavoriteTopicsVC() 
        case 2: delegate?.showInfoVC()  
        default: break
        }
    
    }
}
