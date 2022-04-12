//
//  NSNotification+Name.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 12.04.22.
//

import Foundation


extension Notification.Name {
    
    static func customHeaderDidSelectItem() -> NSNotification.Name {
        return NSNotification.Name("CustomHeaderDidSelectItem")
    }
    
    static func ChangeCellStyle() -> NSNotification.Name {
        return NSNotification.Name("ChangeCellStyle")
    }
    
    static func AddNewTopic() -> NSNotification.Name {
        return NSNotification.Name("AddNewTopic")
    }
}
