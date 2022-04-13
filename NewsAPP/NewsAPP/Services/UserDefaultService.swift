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
        
    func saveTopics(topics: [String]){
        if let jsonData = try? JSONEncoder().encode(topics){
            standart.set(jsonData, forKey: "AddNewTopic")
        }
    }
        
    func loadTopics() -> [String] {
        if let jsonData = standart.data(forKey: "AddNewTopic"),
           let topiocs = try? JSONDecoder().decode([String].self, from: jsonData) {
            return topiocs
        }
        return []
    }
        
    func loadDarkMode() -> Bool {
        return standart.bool(forKey: "DarkMode")
    }
    
    func saveDarkMode(bool: Bool) {
        standart.set(bool, forKey: "DarkMode")
    }
    
    func saveCellStyle(cellStyle: CellStyle) {
        let cell = try? JSONEncoder().encode(cellStyle)
        UserDefaults.standard.set(cell, forKey: "CellStyle")
    }
    
    func loadCellStyle() -> CellStyle {
        guard let data = UserDefaults.standard.data(forKey: "CellStyle"),
              let cell = try? JSONDecoder().decode(CellStyle.self, from: data) else { return .defaultCell }
        return cell
    }
}



enum CellStyle: Codable {
    case defaultCell
    case largeCell
}
