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
    var settingsArray: [SettingsSection] {
        return DefaultSettings.getSettings(type: .mainSettings)
    }
    
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
        case 0: delegate?.showSettingsVC()
        case 1: delegate?.showFavoriteTopicsVC() 
        case 2: delegate?.showInfoVC()  
        default: break
        }
    
    }
}
