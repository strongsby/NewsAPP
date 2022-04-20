//
//  ShowVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 24.03.22.
//

import Foundation
import UIKit


final class ShowVCViewModel: NSObject, ShowVCViewModelProtocol {
    
    //MARK: - CLASS PROPERTIES
    
    private var fileManagerService = FileManagerService()
    private var loadedImage: UIImage?
    var getTitle: String? {
        return article?.title
    }
    var getDescription: String? {
        guard let description = article?.articleDescription else { return nil }
        return description + description + description
    }
    var getSource: String? {
        return article?.source?.name
    }
    var addButtonIsHidden: Bool = false
    var article: Article?
    var delegate: ShowVCViewModelDelegate?
    
    //MARK: INIT
    
    convenience init(art: Article) {
        self.init()
        self.article = art
    }
    
    convenience init(coreDataModel: CoreDataNews) {
        self.init()
        article = Article(source: nil,
                              author: coreDataModel.author,
                              title: coreDataModel.title,
                              articleDescription: coreDataModel.articleDescription,
                              url: coreDataModel.url,
                              urlToImage: coreDataModel.urlToImage,
                              publishedAt: coreDataModel.publishedAt,
                              content: coreDataModel.content)
        addButtonIsHidden = true
    }
    
    //MARK: - CLASS FUNCTIONS
    
    func getImage() {
        guard let urlStr = article?.urlToImage else { return }
        if let image = ImageCacheService.shared.load(urlToImage: urlStr) {
            delegate?.setupImage(image: image)
            loadedImage = image
        } else {
            fileManagerService.loadImage(localName: urlStr) { [ weak self ] image in
                if let image = image {
                    self?.delegate?.setupImage(image: image)
                } else if let url = URL(string: urlStr) {
                    self?.delegate?.loadImage(url: url, completion: { image in
                        ImageCacheService.shared.save(urlToImage: urlStr, image: image)
                        self?.loadedImage = image
                    })
                }
            }
        }
    }
    
    func shareDidTapped() {
        guard let urlStr = article?.url, let url = URL(string: urlStr) else { return }
        delegate?.showVCShowActivityVC(url: url)
    }
    
    func showInSafariDidTapped() {
        guard let urlString = article?.url, let url = URL(string: urlString) else { return }
        delegate?.showInSafari(url: url)
    }
    
    func saveArticle() {
        self.delegate?.showVCShowAlert(title: "Sorry", message: "are you sure you want to save this news") { [ weak self ] in
            guard let article = self?.article else { return }
            CoreDataService.shared.saveCoreDataNews(article: article)
            if let image = self?.loadedImage, let localName = article.urlToImage {
                self?.fileManagerService.save(image: image, localName: localName)
            }
        }
    }
}
