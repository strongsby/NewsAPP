//
//  NewCollectionViewCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 22.03.22.
//

import UIKit

final class NewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(title: String) {
        titleLabel.text = title
    }
}


extension NewCollectionViewCell: NewsAPPNibLoadable {}
