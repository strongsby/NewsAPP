//
//  CoreDataNews+CoreDataProperties.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 16.03.22.
//
//

import Foundation
import CoreData


extension CoreDataNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataNews> {
        return NSFetchRequest<CoreDataNews>(entityName: "CoreDataNews")
    }

    @NSManaged public var author: String?
    @NSManaged public var title: String?
    @NSManaged public var articleDescription: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var content: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?

}

extension CoreDataNews : Identifiable {

}
