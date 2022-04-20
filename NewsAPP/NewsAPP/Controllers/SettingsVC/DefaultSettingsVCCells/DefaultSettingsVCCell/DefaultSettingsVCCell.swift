//
//  DefaultSettingsVCCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 17.03.22.
//

import UIKit


final class DefaultSettingsVCCell: UITableViewCell {
    
    //MARK: - OUTLETS & CLASS PROPERTIES
    
    @IBOutlet private var imageBackgroundColor: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var settingsImage: UIImageView!
    var viewModel: DefaultSettingsVCCellViewModelProtocol! {
        didSet {
            setupAll()
        }
    }
    
    //MARK: - CLASS FUNCTIONS
    
    private func setupLabel() {
        titleLabel.text = viewModel.getLabelText
    }
    
    private func setupSettingsImage() {
        settingsImage.image = viewModel.getImage
        imageBackgroundColor.backgroundColor = viewModel.imageBackColor
    }
    
    private func setupAll() {
        setupSettingsImage()
        setupLabel()
    }
}


//MARK: - EXTENSION NewsAPPNibLoadable

extension DefaultSettingsVCCell: NewsAPPNibLoadable {}
