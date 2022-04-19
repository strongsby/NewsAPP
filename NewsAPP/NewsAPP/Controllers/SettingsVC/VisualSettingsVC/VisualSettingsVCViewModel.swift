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
    
    var settingsArray: [SettingsSection] {
        return DefaultSettings.visualSettings
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
}
