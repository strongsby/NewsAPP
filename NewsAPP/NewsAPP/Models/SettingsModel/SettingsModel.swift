//
//  SettingsModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 18.03.22.
//

import Foundation
import UIKit


struct SettingsSection {
    var headerTitle: String
    var footerTitle: String
    var options: [SettingsOptionsType]
}

enum SettingsOptionsType {
    case DefaultSettingsVCCell(defaultModel: DefaultSettingsOptions)
    case SwitchSettingsOptions(switchModel: SwitchSettingsOptions)
}

struct DefaultSettingsOptions {
    var imageBackgroundColor: UIColor
    var title: String
    var settingsImage: UIImage?
}

struct SwitchSettingsOptions {
    var imageBackgroundColor: UIColor
    var title: String
    var settingsImage: UIImage?
    var switchPosition: (() -> Bool)
    var switchChangeValue: ((_: Bool) -> Void)
}
