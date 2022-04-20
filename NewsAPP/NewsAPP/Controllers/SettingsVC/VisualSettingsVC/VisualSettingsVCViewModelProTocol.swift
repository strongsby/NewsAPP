//
//  VisualSettingsVCViewModelProyocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 11.04.22.
//

import Foundation


protocol VisualSettingsVCViewModelProTocol: NSObject {
    func getSettingsType(indexPath: IndexPath) -> SettingsOptionsType
    var settingsArrayOptionsCount: Int { get }
    var settingsArrayTitleForFooterInSection: String? { get }
    var settingsArrayTitleForHeaderInSection: String? { get }
}
