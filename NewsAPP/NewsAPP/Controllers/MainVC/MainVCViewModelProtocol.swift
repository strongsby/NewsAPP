//
//  MainVCViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation


protocol MainVCViewModelProtocol: NSObject {
    var delegate: MainVCViewModelDelegate? { get set }
    func getArticle(indexPath: IndexPath) -> Article
    func getLastNews()
    func getNewsWithIndex(index: Int)
    var articlesCount: Int { get }
    var cellStyle: CellStyle { get }
    func refreshDidPull()
    func collectionViewDidSelectItemAt(indexPath: IndexPath)
}
