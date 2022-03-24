//
//  NetwokService.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 12.03.22.
//

import Foundation


final class NetwokService {
    
    private var urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=d4d139486e884248b0051c1ad26f8681"
    private var urlForSearch = "https://newsapi.org/v2/everything?sortBy=popularity&apiKey=d4d139486e884248b0051c1ad26f8681&q="
    
    func getLatsNews(complition: @escaping (Result<[Article],Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    complition(.failure(error))
                }
            } else if let data = data {
                do {
                    let news = try JSONDecoder().decode(News.self, from: data)
                    guard let arrayOfArticles = news.articles else { return }
                    DispatchQueue.main.async {
                        complition(.success(arrayOfArticles))
                    }
                } catch {
                    DispatchQueue.main.async {
                        complition(.failure(error))
                    }
                }
            }
        }.resume()
    }
    
    func serchNews(for news: String, complition: @escaping (Result<[Article],Error>) -> Void) {
        guard let url = URL(string: urlForSearch + news) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    complition(.failure(error))
                }
            } else if let data = data {
                do {
                    let news = try JSONDecoder().decode(News.self, from: data)
                    guard let arrayOfArticles = news.articles else { return }
                    DispatchQueue.main.async {
                        complition(.success(arrayOfArticles))
                    }
                } catch {
                    DispatchQueue.main.async {
                        complition(.failure(error))
                    }
                }
            }
        }.resume()
    }
}
