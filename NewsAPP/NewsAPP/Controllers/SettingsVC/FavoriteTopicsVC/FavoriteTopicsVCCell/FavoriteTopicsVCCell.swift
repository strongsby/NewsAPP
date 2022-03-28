//
//  FavoriteTopicsVCCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 21.03.22.
//

import UIKit

final class FavoriteTopicsVCCell: UITableViewCell {
    
    //MARK: - OUTLETS & CLASS PROPERTYES
    
    @IBOutlet private weak var titleLabel: UILabel!
    var viewModel: FavoriteTopicsVCCellViewModelProtocol = FavoriteTopicsVCCellViewModel() {
        didSet {
            setupTitleLabel()
        }
    }

    //MARK: - CLASS FUNCTIOS
    
    private func setupTitleLabel() {
        titleLabel.text = viewModel.getLableTexte()
    }
}


//MARK: - EXTENSIO NewsAPPNibLoadable

extension FavoriteTopicsVCCell: NewsAPPNibLoadable {}
