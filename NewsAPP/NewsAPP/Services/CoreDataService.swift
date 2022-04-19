//
//  CoreDataService.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 16.03.22.
//

import Foundation
import CoreData


final class CoreDataService {
    
    static var shared = CoreDataService()
    private init() {}

    var managedObjectContext: NSManagedObjectContext {
       let context = persistentContainer.viewContext
       context.automaticallyMergesChangesFromParent = true
       return context
    }
    
    var backGroundContext: NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        return context
    }

    var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "NewsAPP")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func backGroundDelete(object: NSManagedObject?) {
        guard let objectID = object?.objectID else { return }
        let newContext = backGroundContext
        newContext.perform {
            do {
                let object = newContext.object(with: objectID)
                newContext.delete(object)
                try newContext.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func saveCoreDataNews(article: Article) {
        let context = backGroundContext
        context.perform {
            do {
                article.addCoreDataNews(context: context)
                try context.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    func saveContext () {
        
        let context = persistentContainer.viewContext
    
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
