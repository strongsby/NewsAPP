//
//  VisualSettingsVCViewModelProyocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 11.04.22.
//

import Foundation


protocol VisualSettingsVCViewModelProyocol: NSObject {
    var settingsArray: [SettingsSection] { get set }
    func getSettingsType(indexPath: IndexPath) -> SettingsOptionsType
    func settingsArrayCounr() -> Int
    func settingsArrayOptionsCount(section: Int) -> Int
    func settingsArrayTitleForFooterInSection(section: Int) -> String?
    func settingsArrayTitleForHeaderInSection(section: Int) -> String?
}
