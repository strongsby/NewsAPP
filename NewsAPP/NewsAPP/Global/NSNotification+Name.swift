//
//  NSNotification+Name.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 12.04.22.
//

import Foundation


extension Notification.Name {
    
    static func ChangeCellStyle() -> NSNotification.Name {
        return NSNotification.Name("CellStyle")   
    }
    
    static func AddNewTopic() -> NSNotification.Name {
        return NSNotification.Name("AddNewTopic")
    }
}
