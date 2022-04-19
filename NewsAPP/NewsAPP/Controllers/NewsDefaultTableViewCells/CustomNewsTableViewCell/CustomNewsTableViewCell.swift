//
//  CustomNewsTableViewCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 31.03.22.
//

import UIKit

class CustomNewsTableViewCell: UITableViewCell, NewsAPPNibLoadable {
    
    //MARK: - OUTLETS & CLASS PROPERTIES

    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var newsImage: DownloadImageView!
    var viewModel: CustomNewsTableViewCellViewModelProtocol! {
        didSet {
            configLabels()
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
    
    private func configLabels() {
        titleLabel.text = viewModel.getTitle
        descriptionLabel.text = viewModel.getDescription
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

