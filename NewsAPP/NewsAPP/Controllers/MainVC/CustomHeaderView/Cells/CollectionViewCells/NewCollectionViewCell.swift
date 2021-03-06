//
//  NewCollectionViewCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 22.03.22.
//

import UIKit


final class NewCollectionViewCell: UICollectionViewCell, NewsAPPNibLoadable {
    
    //MARK: - OUTLETS & CLASS PROPERTIES
    
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
            changeBackGroundColor()
        }
    }
    
    //MARK: - CLASS FUNCS
    
    private func changeBackGroundColor() {
        if isSelected {
            backgroundColor = .systemGray
            titleLabel.textColor = .white
        } else {
            backgroundColor = .systemFill
            titleLabel.textColor = .label
        }
    }
    
    func configCell() {
        titleLabel.text = viewModel.getTitle
    }
}


