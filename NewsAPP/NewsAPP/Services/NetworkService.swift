//
//  NetworkService.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 12.03.22.
//

import Foundation


final class NetworkService {

    private var api = API()

    // MARK: - Call For Last News
    
    func getLatsNews(completion: @escaping (Result<[Article],NetworkError>) -> Void) {
        guard let url = URL(string: api.getURLStringForLastNews()) else {
            DispatchQueue.main.async {
                completion(.failure(.URLError))
            }
            return
        }
        
        taskWithURL(model: News.self, url: url) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let news):
                guard let newsArray = news.articles, !newsArray.isEmpty else {
                    completion(.failure(.invalidNews))
                    return
                }
                completion(.success(newsArray))
            }
        }
    }

    
    // MARK: - Call Fore Searching News
    
    func searchNews(for news: String, completion: @escaping (Result<[Article],NetworkError>) -> Void) {
        
        guard let url = URL(string: api.getURLStringForSearchNews(news: news)) else {
            completion(.failure(.URLError))
            return
        }
        
        taskWithURL(model: News.self, url: url) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let news):
                guard let newsArray = news.articles, !newsArray.isEmpty else {
                    completion(.failure(.invalidNews))
                    return
                }
                completion(.success(newsArray))
            }
        }
    }
    
    //MARK: - CLASS FUNCS
    
    private func taskWithURL<T:Codable>(model: T.Type, url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            do {
                guard error == nil else {
                    throw NetworkError.error(error: error!.localizedDescription)
                }
        
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw NetworkError.invalidResponse
                }
        
                guard let data = data else {
                    throw NetworkError.invalidData
                }
        
                guard let news = try? JSONDecoder().decode(model.self, from: data) else {
                    throw NetworkError.decodingError
                }
                
                DispatchQueue.main.async {
                    completion(.success(news))
                }
            } catch let errors {
                guard let error = errors as? NetworkError else { return }
                DispatchQueue.main.async {
                    completion(.failure(error))
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
        case decodingError
    }
}
