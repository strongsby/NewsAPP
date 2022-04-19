//
//  SavedVCViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation


protocol SavedVCViewModelProtocol: NSObject {
    var delegate: SavedVCViewModelDelegate? { get set }
    var arrayOfCoreDataNewsCount: Int { get }
    var cellStyle: CellStyle { get }
    func deleteCoreDataModel(indexPath: IndexPath)
    func getCoreDataNews(indexPath: IndexPath) -> CoreDataNews
}
