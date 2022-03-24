//
//  NewsTableViewCell.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 14.03.22.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var newsImage: DownloadImageView!
    
    func configCell(article: Article) {
            titleLabel.text = article.title ?? ""
            descriptionLabel.text = article.articleDescription ?? ""
        
        guard let urlStr = article.urlToImage else { return }
        if let image = ImageCacheService.shared.load(urlToImage: urlStr) {
            newsImage.image = image
        } else {
            guard let url = URL(string: urlStr) else { return }
            newsImage.load(url) { image in
                ImageCacheService.shared.save(urlToImage: urlStr, image: image)
            }
        }
        configImage()
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
}


extension NewsTableViewCell: NewsAPPNibLoadable {}
