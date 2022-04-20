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
    @IBOutlet private weak var newsImage: DownloadImageView!
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
        titleLabel.text = nil
        descriptionLabel.text = nil
        newsImage.cancel()
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
    
    func loadImage(url: URL, completion: @escaping ((UIImage) -> Void)) {
        newsImage.load(url) { image in
            completion(image)
        }
    }
    
    func setupImage(image: UIImage) {
        newsImage.image = image
    }
}

