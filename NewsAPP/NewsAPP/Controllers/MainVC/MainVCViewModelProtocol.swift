//
//  MainVCViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation


protocol MainVCViewModelProtocol: NSObject {
    var delegate: MainVCViewModelDelegate? { get set }
    var articlesCount: Int { get }
    var cellStyle: CellStyle { get }
    func getArticle(indexPath: IndexPath) -> Article
    func getLastNews()
    func getNewsWithIndex(index: Int)
    func refreshDidPull()
    func collectionViewDidSelectItemAt(indexPath: IndexPath)
}
