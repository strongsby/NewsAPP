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
    
    private var downloadImageService = DownloadImageService()
    var delegate: CustomNewsTableViewCellViewModelDelegate?
    private var fileManagerService = FileManagerService()
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
    
    func cancel() {
        downloadImageService.cancel()
    }
    
    func getImage() {
        guard let urlStr = newArticle?.urlToImage else { return }
        if let image = ImageCacheService.shared.load(urlToImage: urlStr) {
            delegate?.setupImage(image: image)
        } else {
            fileManagerService.loadImage(localName: urlStr) { [ weak self ] image in
                if let image = image {
                    self?.delegate?.setupImage(image: image)
                } else if let url = URL(string: urlStr) {
                    self?.downloadImageService.load(url) { loadedImage in
                        if self?.newArticle?.urlToImage == urlStr {
                            self?.delegate?.setupImage(image: loadedImage)
                        }
                        ImageCacheService.shared.save(urlToImage: urlStr, image: loadedImage)
                    }
                }
            }
        }
    }
}
