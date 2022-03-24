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
    // context
   var managedObjectContext: NSManagedObjectContext {
       let context = persistentContainer.viewContext
       context.automaticallyMergesChangesFromParent = true
       return context
    }

//    var backGroundContext: NSManagedObjectContext {
//        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
//        context.automaticallyMergesChangesFromParent = true
//        return context
//    }

    var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "NewsAPP")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()

    func saveContext () {
//        persistentContainer.performBackgroundTask { context in
//            if context.hasChanges {
//                do {
//                    try context.save()
//                } catch {
//                    let nserror = error as NSError
//                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//                }
//            }
//        }
        
        
        let context = persistentContainer.viewContext
    
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}




//
//import Foundation
//
//
//import CoreData
//
//final class CoreDataService {
//
//    static var shared = CoreDataService()
//    private init() {}
//    // context
//   var managedObjectContext: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
//
//    var persistentContainer: NSPersistentContainer = {
//
//        let container = NSPersistentContainer(name: "NewsAPP")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//
//        return container
//    }()
//
//    func saveContext () {
////        persistentContainer.performBackgroundTask { context in
////            if context.hasChanges {
////                do {
////                    try context.save()
////                } catch {
////                    let nserror = error as NSError
////                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
////                }
////            }
////        }
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
//
//}
