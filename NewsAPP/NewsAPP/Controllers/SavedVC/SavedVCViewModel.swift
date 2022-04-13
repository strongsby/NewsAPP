//
//  SavedVCViewModel.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import Foundation
import CoreData
import SafariServices


final class SavedVCViewModel: NSObject, SavedVCViewModelProtocol {
    
    //MARK: - CALSS PROPERTYES
    
    private var cellStyles: CellStyle = .defaultCell {
        didSet { delegate?.tableViewReloadData() }
    }
    private var arryOfCoreDataNews: [CoreDataNews] = [] {
        didSet { checkArryOfCoreDataNews() }
    }
    var delegate: SavedVCViewModelDelegate? {
        didSet { checkArryOfCoreDataNews() }
    }
    private var fetchedResultsController: NSFetchedResultsController<CoreDataNews>!
    private var fileManager = FileManagerService()
    
    //MARK: - INIT
    
    override init() {
        super.init()
        setupFetchController()
        loadCoreDataNews()
        loadCellStyleFromUserDefault()
        NotificationCenter.default.addObserver(self, selector: #selector(loadCellStyleFromUserDefault), name: .ChangeCellStyle(), object: nil)
    }
    
    //MARK: - CLASS FUNCTIONS
    
    func getCoreDataNews(indexPath: IndexPath) -> CoreDataNews {
        return arryOfCoreDataNews[indexPath.row]
    }
    
    @objc func loadCellStyleFromUserDefault() {
        cellStyles = UserDefaultService.shared.loadCellStyle()
    }
    
    private func checkArryOfCoreDataNews() {
        switch arryOfCoreDataNews.isEmpty {
        case true: delegate?.addMessageShowWithAnimation()
        case false: delegate?.addMessageViewPutAwayWithAnimation()
        }
    }
    
    func cellStyle() -> CellStyle {
        return cellStyles
    }
    
    func rowDidSelect(indexPath: IndexPath) {
        delegate?.showShowVC(coreDataModel: arryOfCoreDataNews[indexPath.row])
    }
    
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
    
    private func deletFromFileManager(indexPath: IndexPath) {
        guard let localeName = arryOfCoreDataNews[indexPath.row].urlToImage else { return }
        fileManager.deletImage(localeName: localeName)
    }
    
    func deletCoreDataModel(indexPath: IndexPath) {
        delegate?.savedVCShowAllert(title: "Sorry", message: "Are you sure you want to delete this post?") { [ weak self ] in
            self?.deletFromFileManager(indexPath: indexPath)
            CoreDataService.shared.backGroundDelet(object: self?.arryOfCoreDataNews[indexPath.row] )
            self?.arryOfCoreDataNews.remove(at: indexPath.row)
            self?.delegate?.tableViewDeletRowWithAnivation(indexPath: [indexPath])
        }
    }
    
    private func loadCoreDataNews() {
        try? fetchedResultsController.performFetch()
        if let resoult = fetchedResultsController.fetchedObjects {
            delegate?.addMessageViewPutAwayWithAnimation()
            arryOfCoreDataNews = resoult
            delegate?.tableViewReloadData()
        }
    }
}


//MARK: - EXTENSION NSFetchedResultsControllerDelegate

extension SavedVCViewModel: NSFetchedResultsControllerDelegate {
  
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard type == .insert else { return }
        loadCoreDataNews()
    }
}
