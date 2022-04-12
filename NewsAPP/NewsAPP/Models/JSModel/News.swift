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
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}


// MARK: - Article

struct Article: Codable {
    let source: Source?
    let author, title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

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
    let id: String?
    let name: String?
}

