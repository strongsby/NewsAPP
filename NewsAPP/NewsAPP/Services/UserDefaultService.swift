//
//  UserDefaultService.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 21.03.22.
//

import Foundation


final class UserDefaultService {
    
    static let shared = UserDefaultService()
    
    private var standart = UserDefaults.standard
    
    private init() {}
    
    
    
    // save AddNewTopic
    func saveTopics(topics: [String]){
        if let jsonData = try? JSONEncoder().encode(topics){
            standart.set(jsonData, forKey: "AddNewTopic")
        }
    }
    
    // load AddNewTopic
    func loadTopics() -> [String] {
        if let jsonData = standart.data(forKey: "AddNewTopic"),
           let topiocs = try? JSONDecoder().decode([String].self, from: jsonData) {
            return topiocs
        }
        return []
    }
    
    // load darkMode
    func loadDarkMode() -> Bool {
        return standart.bool(forKey: "DarkMode")
    }
    
    // save darkMode
    func saveDarkMode(bool: Bool) {
        standart.set(bool, forKey: "DarkMode")
    }
    
    // save cellStyle
    func saveLargeCellStyle(bool: Bool) {
        standart.set(bool, forKey: "ChangeCellStyle")
    }
    
    // load cellStyle
    func loadLargeCellStyle() -> Bool {
        return standart.bool(forKey: "ChangeCellStyle")
    }
}
