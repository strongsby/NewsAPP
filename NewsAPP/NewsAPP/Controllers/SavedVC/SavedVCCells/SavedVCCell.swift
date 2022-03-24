//
//  SavedVCCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 16.03.22.
//

import UIKit

final class SavedVCCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var newsImage: UIImageView!
    private var fileManagerService = FileManagerService()
    //var url = ""
    
    func configCell(article: CoreDataNews) {
        titleLabel.text = article.title ?? ""
        descriptionLabel.text = article.articleDescription ?? ""
        if let localName = article.urlToImage {
            fileManagerService.loadImage(localName: localName) { [ weak self ] myimage in
                guard let image = myimage else { return }
                self?.newsImage.image = image
            }
        }
    }
    
    private func configImage() {
        newsImage.layer.borderColor = UIColor.systemGray3.cgColor
        newsImage.layer.borderWidth = 1
        newsImage.layer.cornerRadius = 10.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        descriptionLabel.text = nil
        newsImage.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configImage()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}


extension SavedVCCell: NewsAPPNibLoadable {}
