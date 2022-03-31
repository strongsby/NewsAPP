//
//  SavedVCViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation


protocol SavedVCViewModelProtocol: NSObject {
    var arryOfCoreDataNews: [CoreDataNews] { get set }
    var delegate: SavedVCViewModelDelegate? { get set }
    func arryOfCoreDataNewsCount() -> Int
    func deletCoreDataModel(indexPath: IndexPath)
    func rowDidSelect(indexPath: IndexPath)
    func cellStyle() -> Bool
}
