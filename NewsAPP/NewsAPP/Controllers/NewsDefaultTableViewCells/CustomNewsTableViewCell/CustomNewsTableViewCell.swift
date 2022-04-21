//
//  CustomNewsTableViewCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 31.03.22.
//

import UIKit

final class CustomNewsTableViewCell: UITableViewCell, NewsAPPNibLoadable {
    
    //MARK: - OUTLETS & CLASS PROPERTIES

    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var newsImage: UIImageView!
    var viewModel: CustomNewsTableViewCellViewModelProtocol! {
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
    
    private func cancel() {
        viewModel.cancel()
        titleLabel.text = nil
        descriptionLabel.text = nil
        newsImage.image = UIImage(named: "defaultImage")
    }
    
    private func bind() {
        viewModel.delegate = self
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

extension CustomNewsTableViewCell: CustomNewsTableViewCellViewModelDelegate {
    
    func setupImage(image: UIImage) {
        newsImage.image = image
    }
}

