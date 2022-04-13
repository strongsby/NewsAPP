//
//  SearchVCViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation


protocol SearchVCViewModelProtocol: NSObject {
    var delegate: SearchVCViewModelDelegate? { get set }
    func getNewsWithString(title: String?)
    func newsArrayCount() -> Int
    func cellStyle() -> CellStyle
    func refreshDidPull()
    func getArticle(indexPath: IndexPath) -> Article
}
