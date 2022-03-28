//
//  DefaultSettingsVCCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 17.03.22.
//

import UIKit

final class DefaultSettingsVCCell: UITableViewCell {
    
    //MARK: - OUTLETS & CLASS PROPERTYES
    
    @IBOutlet private var imageBackgroundColor: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var settingsImage: UIImageView!
    var viewModel: DefaultSettingsVCCellViewModelProtocol = DefaultSettingsVCCellViewModel() {
        didSet {
            setupAll()
        }
    }
    
    //MARK: - CLASS FUNCTIONS
    
    private func setupLabel() {
        titleLabel.text = viewModel.getLabelText()
    }
    
    private func setupSettingsImage() {
        guard let imageSettings = viewModel.getImage() else { return }
        settingsImage.image = imageSettings.image
        imageBackgroundColor.backgroundColor = imageSettings.color
    }
    
    private func setupAll() {
        setupSettingsImage()
        setupLabel()
    }
}


//MARK: - EXTENSION NewsAPPNibLoadable

extension DefaultSettingsVCCell: NewsAPPNibLoadable {}
