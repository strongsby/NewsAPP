//
//  SavedVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import Foundation
import CoreData
import SafariServices


protocol SavedVCViewModelProtocol: NSObject {
    var arryOfCoreDataNews: [CoreDataNews] { get set }
    var delegate: SavedVCViewModelDelegate? { get set }
    func arryOfCoreDataNewsCount() -> Int
    func deletCoreDataModel(indexPath: IndexPath)
    func rowDidSelect(indexPath: IndexPath)
}


final class SavedVCViewModel: NSObject, SavedVCViewModelProtocol {
    func rowDidSelect(indexPath: IndexPath) {
        guard let strUrl = arryOfCoreDataNews[indexPath.row].url, let url = URL(string: strUrl) else { return }
        delegate?.showInSafari(url: url)
    }
    
    
    var arryOfCoreDataNews: [CoreDataNews] = [] {
        didSet { delegate?.tableViewReloadData() }
    }
    var delegate: SavedVCViewModelDelegate?
    private var fetchedResultsController: NSFetchedResultsController<CoreDataNews>!
    private var fileManager = FileManagerService()
    
    private func setupFetchController() {
        let request = NSFetchRequest<CoreDataNews>(entityName: "CoreDataNews")
        let sortedDescription = NSSortDescriptor(key: "publishedAt", ascending: true)
        request.sortDescriptors = [sortedDescription]
        fetchedResultsController = NSFetchedResultsController<CoreDataNews>(fetchRequest: request, managedObjectContext: CoreDataService.shared.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
    }
    
    func arryOfCoreDataNewsCount() -> Int {
        return arryOfCoreDataNews.count
    }
    
    func deletCoreDataModel(indexPath: IndexPath) {
        delegate?.savedVCShowAllert(title: "Sorry", message: "Are you sure you want to delete this post?") { [ weak self ] in
            guard let localeName = self?.arryOfCoreDataNews[indexPath.row].urlToImage else { return }
            self?.fileManager.deletImage(localeName: localeName)
            if let coreDataModel = self?.arryOfCoreDataNews[indexPath.row] {
            CoreDataService.shared.managedObjectContext.delete(coreDataModel)
            self?.arryOfCoreDataNews.remove(at: indexPath.row)
            CoreDataService.shared.saveContext()
            }
        }
    }
    
    private func loadCoreDataNews() {
        try? fetchedResultsController.performFetch()
        if let resoult = fetchedResultsController.fetchedObjects {
            arryOfCoreDataNews = resoult
        }
    }
    
    override init() {
        super.init()
        setupFetchController()
        loadCoreDataNews()
    }
}


extension SavedVCViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        loadCoreDataNews()
    }
}
