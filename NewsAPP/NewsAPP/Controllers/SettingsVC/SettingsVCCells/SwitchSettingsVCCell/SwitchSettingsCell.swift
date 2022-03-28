//
//  SwitchSettingsCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 17.03.22.
//

import UIKit


final class SwitchSettingsCell: UITableViewCell {
    
    //MARK: - OUTLETS & CLASS PROPERTYES
    
    @IBOutlet private weak var imageBackgroundColor: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var settingsImage: UIImageView!
    @IBOutlet private weak var darkModeSwitch: UISwitch!
    var viewModel: SwitchSettingsCellViewModelProtocol = SwitchSettingsCellViewModel() {
        didSet {
            setupAll()
        }
    }
    
    //MARK: - CLASS FUNCTIONS
    
    private func setupdarkModeSwitch() {
        darkModeSwitch.isOn = viewModel.getSwitchPOsition()
    }
    
    private func setupImage() {
        guard let imageSettings = viewModel.getImage() else { return }
        settingsImage.image = imageSettings.image
        imageBackgroundColor.backgroundColor = imageSettings.color
    }
    
    private func setupLable() {
        titleLabel.text = viewModel.getLableTitle()
    }
    
    private func setupAll() {
        setupImage()
        setupLable()
        setupdarkModeSwitch()
    }
    
    @IBAction func switchDidTapped() {
        viewModel.switchChangeValue(isOn: darkModeSwitch.isOn)
    }
}


//MARK: - EXTENSION NewsAPPNibLoadable

extension SwitchSettingsCell: NewsAPPNibLoadable {}
