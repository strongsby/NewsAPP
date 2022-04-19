//
//  SearchVCViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation


protocol SearchVCViewModelProtocol: NSObject {
    var delegate: SearchVCViewModelDelegate? { get set }
    var newsArrayCount: Int { get }
    var cellStyle: CellStyle { get }
    func getNewsWithString(title: String?)
    func refreshDidPull()
    func getArticle(indexPath: IndexPath) -> Article
}
