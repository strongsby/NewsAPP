//
//  SavedVCCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 16.03.22.
//

import UIKit


final class SavedVCCell: UITableViewCell {
    
    //MARK: - OUTLETS & CLASS PROPERTYES
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var newsImage: UIImageView!
    private var fileManagerService = FileManagerService()
    var viewModel: SavedVCCellViewModelProtocol = SavedVCCellViewModel() {
        didSet {
            setupLablesText()
            setupImage()
        }
    }
    
    //MARK: - INIT
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancel()
    }
    
    //MARK: - CLASS FUNCTIONS
    
    private func setupLablesText() {
        let text = viewModel.getTextForLables()
        titleLabel.text = text.title
        descriptionLabel.text = text.description
    }
    
    private func setupImage() {
        guard let localName = viewModel.getImageLocalName() else { return }
        fileManagerService.loadImage(localName: localName) { [ weak self ] image in
            self?.newsImage.image = image
        }
    }
    
    private func cancel() {
        titleLabel.text = nil
        descriptionLabel.text = nil
        newsImage.image = nil
    }
}


//MARK: - EXTENSION NewsAPPNibLoadable

extension SavedVCCell: NewsAPPNibLoadable {}
