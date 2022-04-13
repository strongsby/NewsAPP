//
//  ShowVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 24.03.22.
//

import Foundation
import UIKit


final class ShowVCViewModel: NSObject, ShowVCViewModelProtocol {
    
    //MARK: - CLASS PROPERTYES
    
    private var fileManagerService = FileManagerService()
    private var addButtonIsHiddenFlag = false
    var article: Article?
    var delegate: ShowVCViewModelDelegate?
    
    //MARK: INIT
    
    convenience init(art: Article) {
        self.init()
        self.article = art
    }
    
    convenience init(coreDataModel: CoreDataNews) {
        self.init()
        let newArticle = Article(source: nil,
                              author: coreDataModel.author,
                              title: coreDataModel.title,
                              articleDescription: coreDataModel.articleDescription,
                              url: coreDataModel.url,
                              urlToImage: coreDataModel.urlToImage,
                              publishedAt: coreDataModel.publishedAt,
                              content: coreDataModel.content)
        article = newArticle
        addButtonIsHiddenFlag = true
    }
    
    //MARK: - CLASS FUNCTIONS
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let ofsetY = 250 - (scrollView.contentOffset.y )
        let minMax = max(250, ofsetY)
        delegate?.changeImageHeightConstrain(height: minMax)
    }
    
    func addButtonIsHidden() -> Bool {
        return addButtonIsHiddenFlag 
    }
    
    func shareDidTapped() {
        guard let urlStr = article?.url, let url = URL(string: urlStr) else { return }
        delegate?.showVCShowActivityVC(url: url)
    }
    
    func getCashedImage() -> UIImage? {
        guard let urlToImage = article?.urlToImage, let image = ImageCacheService.shared.load(urlToImage: urlToImage) else { return nil }
            return image
    }
    
    func getImageURL() -> URL? {
        guard let urlStr = article?.urlToImage, let url = URL(string: urlStr) else { return nil }
        return url
    }
    
    func getLablesText() -> (title: String?, description: String?, sourse: String?) {
        return (article?.title, article?.articleDescription, article?.source?.name)
    }
    
    func showInSafariDidTapped() {
        guard let urlstr = article?.url, let url = URL(string: urlstr) else { return }
        delegate?.showInSafari(url: url)
    }
    
    func saveArticle(image: UIImage?) {
        self.delegate?.showVCShowAllert(title: "Sorry", message: "are you sure you want to save this news") { [ weak self ] in
            guard let article = self?.article else { return }
            let context = CoreDataService.shared.backGroudContext
            context.perform {
                do {
                    article.addCoreDataNews(context: context)
                    try context.save()
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            if let image = image, let localName = article.urlToImage {
                self?.fileManagerService.save(image: image, localName: localName)
            }
        }
    }
}
