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
    
    private var newArticle: Article?
    
    //MARK: - LIFE CYCLE
    
    convenience init(article: Article) {
        self.init()
        newArticle = article
    }
    
    //MARK: - CLASS FUNCS
    
    func getTextForLable() -> (title: String, description: String) {
        return (newArticle?.title ?? "", newArticle?.articleDescription ?? "")
    }
    
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
