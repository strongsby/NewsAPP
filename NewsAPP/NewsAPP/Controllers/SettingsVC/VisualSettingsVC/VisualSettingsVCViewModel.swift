//
//  VisualSettingsVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 11.04.22.
//

import Foundation
import UIKit


final class VisualSettingsVCViewModel:  NSObject, VisualSettingsVCViewModelProTocol {
    
    //MARK: - CLASS PROPERTIES
    
    var settingsArrayOptionsCount: Int {
        return settings.options.count
    }
    var settingsArrayTitleForFooterInSection: String? {
        return settings.footerTitle
    }
    var settingsArrayTitleForHeaderInSection: String? {
        return settings.headerTitle
    }
    private var settings: SettingsSection {
        return DefaultSettings.visualSettings
    }
    
    //MARK: - CLASS FUNCTIONS
    
    func getSettingsType(indexPath: IndexPath) -> SettingsOptionsType {
        return settings.options[indexPath.row]
    }
}
