//
//  CoreDataNews+CoreDataClass.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 16.03.22.
//
//

import Foundation
import CoreData

@objc(CoreDataNews)
public class CoreDataNews: NSManagedObject {
    
    convenience init?(moc: NSManagedObjectContext){
        if let entity = NSEntityDescription.entity(forEntityName: "CoreDataNews", in: moc){
            self.init(entity: entity, insertInto: moc)
        } else {
            return nil
        }
    }
}
