//
//  CustomNewsTableViewCellViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 31.03.22.
//

import Foundation
import UIKit


final class CustomNewsTableViewCellViewModel: NSObject, CustomNewsTableViewCellViewModelProtocol {
    
    //MARK: - CLASS PROPERTIES
    
    var getTitle: String? {
        return newArticle?.title
    }
    var getDescription: String? {
        return newArticle?.articleDescription
    }
    private var newArticle: Article?
    
    //MARK: - LIFE CYCLE
    
    convenience init(article: Article) {
        self.init()
        newArticle = article
    }
    
    convenience init(coreDataModel: CoreDataNews) {
        self.init()
        let article = Article(source: nil,
                              author: coreDataModel.author,
                              title: coreDataModel.title,
                              articleDescription: coreDataModel.articleDescription,
                              url: coreDataModel.url,
                              urlToImage: coreDataModel.urlToImage,
                              publishedAt: coreDataModel.publishedAt,
                              content: coreDataModel.content)
        newArticle = article
    }
    
    //MARK: - CLASS FUNCS
    
    func getImage() -> (image: UIImage?, imageURL: URL?) {
        guard let urlStr = newArticle?.urlToImage else { return (nil, nil) }
        if let image = ImageCacheService.shared.load(urlToImage: urlStr) {
            return (image,nil)
        } else if let url = URL(string: urlStr) {
            return (nil, url)
        }
        return (nil, nil)
    }
    
    func saveImage(image: UIImage) {
        guard let urlToImage = newArticle?.urlToImage else { return }
        ImageCacheService.shared.save(urlToImage: urlToImage, image: image)
    }
}
