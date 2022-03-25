//
//  NetwokService.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 12.03.22.
//

import Foundation


final class NetwokService {

    private var api = API()

    // MARK: - Call For Last News
    
    func getLatsNews(complition: @escaping (Result<[Article],NetworkError>) -> Void) {
        guard let url = URL(string: api.getURLStringForLastNews()) else {
            DispatchQueue.main.async {
                complition(.failure(.URLError))
            }
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    complition(.failure(.error(error: error!.localizedDescription)))
                }
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    complition(.failure(.invalidResponse))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    complition(.failure(.invalidData))
                }
                return
            }

            do {
                let news = try JSONDecoder().decode(News.self, from: data)
                guard let arrayOfArticles = news.articles else {
                    DispatchQueue.main.async {
                        complition(.failure(.invalidNews))
                    }
                    return
                }
                DispatchQueue.main.async {
                    complition(.success(arrayOfArticles))
                }
            } catch let err {
                DispatchQueue.main.async {
                    complition(.failure(.decodingError(error: err.localizedDescription)))
                }
            }
        }.resume()
    }

    
    // MARK: - Call Fore Serching News
    
    func serchNews(for news: String, complition: @escaping (Result<[Article],NetworkError>) -> Void) {
        guard let url = URL(string: api.getURLStringForSearchNews(news: news)) else {
            DispatchQueue.main.async {
                complition(.failure(.URLError))
            }
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    complition(.failure(.error(error: error!.localizedDescription)))
                }
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    complition(.failure(.invalidResponse))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    complition(.failure(.invalidData))
                }
                return
            }

            do {
                let news = try JSONDecoder().decode(News.self, from: data)
                guard let arrayOfArticles = news.articles else {
                    DispatchQueue.main.async {
                        complition(.failure(.invalidNews))
                    }
                    return
                }
                DispatchQueue.main.async {
                    complition(.success(arrayOfArticles))
                }
            } catch let err {
                DispatchQueue.main.async {
                    complition(.failure(.decodingError(error: err.localizedDescription)))
                }
            }
        }.resume()
    }

    // MARK: - Handling Errors
    
    enum NetworkError: Error {
        case URLError
        case invalidResponse
        case invalidData
        case invalidNews
        case error(error: String)
        case decodingError(error: String)
    }
}
