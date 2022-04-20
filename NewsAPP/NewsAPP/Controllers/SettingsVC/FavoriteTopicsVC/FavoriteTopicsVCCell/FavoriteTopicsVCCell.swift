//
//  FavoriteTopicsVCCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 21.03.22.
//

import UIKit


final class FavoriteTopicsVCCell: UITableViewCell {
    
    //MARK: - OUTLETS & CLASS PROPERTIES
    
    @IBOutlet private weak var titleLabel: UILabel!
    var viewModel: FavoriteTopicsVCCellViewModelProtocol! {
        didSet {
            setupTitleLabel()
        }
    }

    //MARK: - CLASS FUNCS
    
    private func setupTitleLabel() {
        titleLabel.text = viewModel.getLabelsText
    }
}


//MARK: - EXTENSION NewsAPPNibLoadable

extension FavoriteTopicsVCCell: NewsAPPNibLoadable {}
