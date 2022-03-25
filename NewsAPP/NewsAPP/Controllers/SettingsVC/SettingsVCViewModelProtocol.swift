//
//  SettingsVCViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation


protocol SettingsVCViewModelProtocol: NSObject {
    var settingsArray: [SettingsSection] { get set }
    func settingsArrayCounr() -> Int
    func settingsArrayOptionsCount(section: Int) -> Int
    func settingsArrayTitleForFooterInSection(section: Int) -> String?
    func settingsArrayTitleForHeaderInSection(section: Int) -> String?
    func tableViewDidSelectRowAT(indexPath: IndexPath)
    var delegate: SettingsVCViewModelDelegate? { get set }
}
