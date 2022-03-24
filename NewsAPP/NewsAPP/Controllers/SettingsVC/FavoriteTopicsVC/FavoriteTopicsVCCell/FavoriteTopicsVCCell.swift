//
//  FavoriteTopicsVCCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 21.03.22.
//

import UIKit

final class FavoriteTopicsVCCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(title: String) {
        titleLabel.text = title
    }
}


extension FavoriteTopicsVCCell: NewsAPPNibLoadable {}
