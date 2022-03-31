//
//  CustomeSearchVCCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 30.03.22.
//

import UIKit

class CustomeSearchVCCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var newsImage: DownloadImageView!
    var viewModel: CustomeSearchVCCellViewModelProtocol = CustomeSearchVCCellViewModel() {
        didSet {
            configLables()
            configImage()
        }
    }
    
    //MARK: - LIFE CYCLE
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancel()
    }
    
    //MARK: - CLASS FUNCS
    
    private func cancel() {
        titleLabel.text = nil
        descriptionLabel.text = nil
        newsImage.cancel()
    }
    
    private func configLables() {
        let lablesText = viewModel.getTextForLable()
        titleLabel.text = lablesText.title
        descriptionLabel.text = lablesText.description
    }
    
    private func configImage() {
        if let image = viewModel.getImage().image {
            newsImage.image = image
        } else if let url = viewModel.getImage().imageURL {
            newsImage.load(url) { [ weak self ] image in
                self?.newsImage.image = image
                self?.viewModel.saveImage(image: image)
            }
        }
    }
}


extension CustomeSearchVCCell: NewsAPPNibLoadable {}
