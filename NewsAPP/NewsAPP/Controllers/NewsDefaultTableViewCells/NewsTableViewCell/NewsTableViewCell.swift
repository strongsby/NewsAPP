//
//  NewsTableViewCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 14.03.22.
//

import UIKit

final class NewsTableViewCell: UITableViewCell, NewsAPPNibLoadable {
    
    //MARK: - OUTLETS & CLASS PROPERTIES
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var newsImage: UIImageView! 
    var viewModel: NewsTableViewCellViewModelProtocol! {  
        didSet {
            bind()
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
    
    private func bind() {
        viewModel.delegate = self
    }
    
    private func cancel() {
        viewModel.cancel()
        titleLabel.text = nil
        descriptionLabel.text = nil
        newsImage.image = UIImage(named: "defaultImage")
    }
    
    private func configLabels() {
        titleLabel.text = viewModel.getTitle
        descriptionLabel.text = viewModel.getDescription
    }
    
    private func configImage() {
        viewModel.getImage()
    }
}

//MARK: - EXTENSION

extension NewsTableViewCell: NewsTableViewCellViewModelDelegate {
    
    func setupImage(image: UIImage) {
        newsImage.image = image
    }
}


