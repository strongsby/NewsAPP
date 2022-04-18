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
    
    //MARK: - CALSS PROPERTIES
    
    private var cellStyles: CellStyle = .defaultCell {
        didSet { delegate?.tableViewReloadData() }
    }
    private var arrayOfCoreDataNews: [CoreDataNews] = [] {
        didSet { checkArrayOfCoreDataNews() }
    }
    var delegate: SavedVCViewModelDelegate? {
        didSet { checkArrayOfCoreDataNews() }
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
        return arrayOfCoreDataNews[indexPath.row]
    }
    
    @objc func loadCellStyleFromUserDefault() {
        cellStyles = UserDefaultService.shared.loadCellStyle()
    }
    
    private func checkArrayOfCoreDataNews() {
        switch arrayOfCoreDataNews.isEmpty {
        case true: delegate?.addMessageShowWithAnimation()
        case false: delegate?.addMessageViewPutAwayWithAnimation()
        }
    }
    
    func cellStyle() -> CellStyle {
        return cellStyles
    }
    
    func rowDidSelect(indexPath: IndexPath) {
        delegate?.showShowVC(coreDataModel: arrayOfCoreDataNews[indexPath.row])
    }
    
    private func setupFetchController() {
        let request = NSFetchRequest<CoreDataNews>(entityName: "CoreDataNews")
        let sortedDescription = NSSortDescriptor(key: "publishedAt", ascending: true)
        request.sortDescriptors = [sortedDescription]
        fetchedResultsController = NSFetchedResultsController<CoreDataNews>(fetchRequest: request, managedObjectContext: CoreDataService.shared.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
    }
    
    func arrayOfCoreDataNewsCount() -> Int {
        return arrayOfCoreDataNews.count
    }
    
    private func deleteFromFileManager(indexPath: IndexPath) {
        guard let localeName = arrayOfCoreDataNews[indexPath.row].urlToImage else { return }
        fileManager.deleteImage(localeName: localeName)
    }
    
    func deleteCoreDataModel(indexPath: IndexPath) {
        delegate?.savedVCShowAlert(title: "Sorry", message: "Are you sure you want to delete this post?") { [ weak self ] in
            self?.deleteFromFileManager(indexPath: indexPath)
            CoreDataService.shared.backGroundDelete(object: self?.arrayOfCoreDataNews[indexPath.row] )
            self?.arrayOfCoreDataNews.remove(at: indexPath.row)
            self?.delegate?.tableViewDeleteRowWithAnimation(indexPath: [indexPath])
        }
    }
    
    private func loadCoreDataNews() {
        try? fetchedResultsController.performFetch()
        if let result = fetchedResultsController.fetchedObjects {
            delegate?.addMessageViewPutAwayWithAnimation()
            arrayOfCoreDataNews = result
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
