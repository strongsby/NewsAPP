//
//  API.swift
//  NewsAPP
// fc891b5165b74a3eb0b7a55737f6c06b
//d4d139486e884248b0051c1ad26f8681
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation


final class API {
    
    private var apiKey = "fc891b5165b74a3eb0b7a55737f6c06b"
    private var urlForLastNews = "https://newsapi.org/v2/top-headlines?country=us&apiKey="
    private var urlForSearch = "https://newsapi.org/v2/everything?sortBy=popularity&apiKey="

    func getURLStringForLastNews() -> String {
        return urlForLastNews + apiKey
    }
    
    func getURLStringForSearchNews(news: String) -> String {
        let serchString = "&q=" + news
        return urlForSearch + apiKey + serchString
    }
}
