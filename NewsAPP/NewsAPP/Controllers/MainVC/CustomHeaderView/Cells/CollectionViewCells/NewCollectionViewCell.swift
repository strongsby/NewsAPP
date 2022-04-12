//
//  NewCollectionViewCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 22.03.22.
//

import UIKit

final class NewCollectionViewCell: UICollectionViewCell {
    
    //MARK: - OUTLETS & CLASS PROPERTYES
    
    @IBOutlet private weak var titleLabel: UILabel! 
    var viewModel: NewCollectionViewCellViewModelProtocol = NewCollectionViewCellViewModel() {
        didSet { configCell() }
    }

    //MARK: - LIFE CYCLE
    
        override func awakeFromNib() {
        super.awakeFromNib()
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .systemGray
                titleLabel.textColor = .white
            } else {
                backgroundColor = .systemFill
                titleLabel.textColor = .label
            }
        }
    }
    
    //MARK: - CLASS FUNCS
    
    func configCell() {
        titleLabel.text = viewModel.getTitle()
    }
}


extension NewCollectionViewCell: NewsAPPNibLoadable {}