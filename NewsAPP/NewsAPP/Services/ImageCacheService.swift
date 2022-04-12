//
//  ImageCacheService.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 14.03.22.
//

import UIKit


final class ImageCacheService {
    
    static let shared = ImageCacheService()
    
    private let cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 50
        cache.totalCostLimit = 200 * 1024 * 1024 
        return cache
    }()
    
    func save(urlToImage: String, image: UIImage?) {
        guard let image = image else { return }
        cache.setObject(image, forKey: urlToImage as NSString)
    }
    
    func load(urlToImage: String) -> UIImage? {
        return cache.object(forKey: urlToImage as NSString)
    }
}
