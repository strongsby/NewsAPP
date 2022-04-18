//
//  News.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 12.03.22.
//

import Foundation
import CoreData


// MARK: - News

struct News: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}


// MARK: - Article

struct Article: Codable {
    var source: Source?
    var author, title, articleDescription: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
    
    func addCoreDataNews(context: NSManagedObjectContext) {
        guard let news = CoreDataNews(moc: context) else { return  }     // backgroundContext
        news.url = url
        news.urlToImage  = urlToImage
        news.id = source?.id
        news.name = source?.name
        news.content = content
        news.publishedAt = publishedAt
        news.author = author
        news.title = title
        news.articleDescription = articleDescription
    }
}


// MARK: - Source

struct Source: Codable {
    var id: String?
    var name: String?
}

