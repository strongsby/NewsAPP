//
//  SwitchSettingsCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 17.03.22.
//

import UIKit


final class SwitchSettingsCell: UITableViewCell, NewsAPPNibLoadable {
    
    //MARK: - OUTLETS & CLASS PROPERTIES
    
    @IBOutlet private weak var imageBackgroundColor: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var settingsImage: UIImageView!
    @IBOutlet private weak var darkModeSwitch: UISwitch!
    var viewModel:  SwitchSettingsCellViewModelProtocol! {
        didSet {
            setupAll()
        }
    }
    
    //MARK: - CLASS FUNCTIONS
    
    private func setupDarkModeSwitch() {
        darkModeSwitch.isOn = viewModel.getSwitchPosition
    }
    
    private func setupImage() {
        settingsImage.image = viewModel.getImage
        imageBackgroundColor.backgroundColor = viewModel.imageBackColor
    }
    
    private func setupLabels() {
        titleLabel.text = viewModel.getLabelsTitle
    }
    
    private func setupAll() {
        setupImage()
        setupLabels()
        setupDarkModeSwitch()
    }
    
    @IBAction func switchDidTapped() {
        viewModel.switchChangeValue(isOn: darkModeSwitch.isOn)
    }
}

