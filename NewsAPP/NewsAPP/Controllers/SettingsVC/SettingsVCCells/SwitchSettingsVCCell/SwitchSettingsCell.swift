//
//  SwitchSettingsCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 17.03.22.
//

import UIKit

final class SwitchSettingsCell: UITableViewCell {
    
    private let userDefaultService = UserDefaultService()
    @IBOutlet private weak var imageBackgroundColor: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var settingsImage: UIImageView!
    @IBOutlet private weak var darkModeSwitch: UISwitch! {
        didSet {
            darkModeSwitch.isOn = userDefaultService.loadDarkMode()
        }
    }
 
    func configCell(model: SwitchSettingsOptions) {
        imageBackgroundColor.backgroundColor = model.imageBackgroundColor
        titleLabel.text = model.title
        settingsImage.image = model.settingsImage        
    }
    
    @IBAction func switchDidTapped() {
        
        if let appDelegate = UIApplication.shared.windows.first {
                switch darkModeSwitch.isOn {
                case true:
                    appDelegate.overrideUserInterfaceStyle = .dark
                    userDefaultService.saveDarkMode(bool: true)
                case false:
                    appDelegate.overrideUserInterfaceStyle = .light
                    userDefaultService.saveDarkMode(bool: false)
            }
        }
    }
}


extension SwitchSettingsCell: NewsAPPNibLoadable {}
