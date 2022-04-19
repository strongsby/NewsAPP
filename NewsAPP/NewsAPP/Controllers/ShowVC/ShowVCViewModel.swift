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
    
    func setImage(downloadImageView: DownloadImageView) {
        if let image = getCashedImage() {
            downloadImageView.image = image
        } else if let url = getImageURL() {
            downloadImageView.load(url) {  image in
                downloadImageView.image = image
            }
        }
    }
    
    func getImageURL() -> URL? {
        guard let urlStr = article?.urlToImage else { return nil }
        return URL(string: urlStr)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = 250 - (scrollView.contentOffset.y )
        let minMax = max(250, offsetY)
        delegate?.changeImageHeightConstrain(height: minMax)
    }
    
    func shareDidTapped() {
        guard let urlStr = article?.url, let url = URL(string: urlStr) else { return }
        delegate?.showVCShowActivityVC(url: url)
    }
    
    func getCashedImage() -> UIImage? {
        guard let urlToImage = article?.urlToImage, let image = ImageCacheService.shared.load(urlToImage: urlToImage) else { return nil }
            return image
    }
    
    func showInSafariDidTapped() {
        guard let urlString = article?.url, let url = URL(string: urlString) else { return }
        delegate?.showInSafari(url: url)
    }
    
    func saveArticle(image: UIImage?) {
        self.delegate?.showVCShowAlert(title: "Sorry", message: "are you sure you want to save this news") { [ weak self ] in
            guard let article = self?.article else { return }
            CoreDataService.shared.saveCoreDataNews(article: article)
            if let image = image, let localName = article.urlToImage {
                self?.fileManagerService.save(image: image, localName: localName)
            }
        }
    }
}
