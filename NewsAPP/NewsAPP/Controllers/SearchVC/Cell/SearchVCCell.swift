//
//  SearchVCCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 15.03.22.
//

import UIKit

final class SearchVCCell: UITableViewCell {
    
    @IBOutlet private weak var newsImage: DownloadImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func configCell(article: Article) {
            titleLabel.text = article.title ?? ""
            descriptionLabel.text = article.articleDescription ?? ""

        guard let urlToImage = article.urlToImage else { return }
        if let image = ImageCacheService.shared.load(urlToImage: urlToImage) {
            newsImage.image = image
        } else {
            guard let url = URL(string: urlToImage) else { return }
            newsImage.load(url) { image in
                ImageCacheService.shared.save(urlToImage: urlToImage, image: image)
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
        newsImage.cancel()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configImage()
        // Initialization code
    }
}


extension SearchVCCell: NewsAPPNibLoadable {}
