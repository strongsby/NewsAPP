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
    var article: Article?
    var delegate: ShowVCViewModelDelegate?
    
    //MARK: INIT
    
    convenience init(art: Article) {
        self.init()
        self.article = art
    }
    
    //MARK: - CLASS FUNCTIONS
    
    func getCashedImage() -> UIImage? {
        guard let urlToImage = article?.urlToImage, let image = ImageCacheService.shared.load(urlToImage: urlToImage) else { return nil }
            return image
    }
    
    func getImageURL() -> URL? {
        guard let urlStr = article?.urlToImage, let url = URL(string: urlStr) else { return nil }
        return url
    }
    
    func getLablesText() -> (title: String, description: String, sourse: String) {
        let title = article?.title ?? ""
        let description = article?.content ?? ""
        let sourse = article?.source?.name ?? ""
        return (title, description, sourse)
    }
    
    func showInSafariDidTapped() {
        guard let urlstr = article?.url, let url = URL(string: urlstr) else { return }
        delegate?.showInSafari(url: url)
    }
    
    func saveArticle(image: UIImage?) {
        self.delegate?.ShowVCShowAllert(title: "Sorry", message: "are you sure you want to save this news") { [ weak self ] in
            guard let article = self?.article else { return }
            let newContext = CoreDataService.shared.persistentContainer.newBackgroundContext()
            newContext.perform {
                do {
                    article.addCoreDataNews(context: newContext)
                    try newContext.save()
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
