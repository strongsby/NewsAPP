//
//  DateFormator+SerchDate.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 15.03.22.
//

import Foundation


extension DateFormatter {
    
    func lastDateForSearch() -> String {
        dateFormat = "yyyy-MM-dd"
        return string(from: Date())
    }
}
