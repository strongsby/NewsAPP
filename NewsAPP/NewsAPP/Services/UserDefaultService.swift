//
//  UserDefaultService.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 21.03.22.
//

import Foundation


final class UserDefaultService {
    
    static let shared = UserDefaultService()
    
    // save AddNewTopic
    func saveTopics(topics: [String]){
        if let jsonData = try? JSONEncoder().encode(topics){
            UserDefaults.standard.set(jsonData, forKey: "AddNewTopic")
        }
    }
    
    // load AddNewTopic
    func loadTopics() -> [String] {
        if let jsonData = UserDefaults.standard.data(forKey: "AddNewTopic"),
           let topiocs = try? JSONDecoder().decode([String].self, from: jsonData) {
            return topiocs
        }
        return []
    }
    
    // load darkMode
    func loadDarkMode() -> Bool {
        return UserDefaults.standard.bool(forKey: "DarkMode")
    }
    
    // save darkMode
    func saveDarkMode(bool: Bool) {
        UserDefaults.standard.set(bool, forKey: "DarkMode")
    }
    
    // save cellStyle
    func saveLargeCellStyle(bool: Bool) {
        UserDefaults.standard.set(bool, forKey: "ChangeCellStyle")
    }
    
    // load cellStyle
    func loadLargeCellStyle() -> Bool {
        return UserDefaults.standard.bool(forKey: "ChangeCellStyle")
    }
}
