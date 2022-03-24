//
//  DefaultSettingsVCCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 17.03.22.
//

import UIKit

final class DefaultSettingsVCCell: UITableViewCell {
    
    @IBOutlet private var imageBackgroundColor: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var settingsImage: UIImageView!
    
    func cofigCell(model: DefaultSettingsOptions) {
        imageBackgroundColor.backgroundColor = model.imageBackgroundColor
        titleLabel.text = model.title
        settingsImage.image = model.settingsImage
    }
}


extension DefaultSettingsVCCell: NewsAPPNibLoadable {}
