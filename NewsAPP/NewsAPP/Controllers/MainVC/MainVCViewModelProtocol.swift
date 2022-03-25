//
//  MainVCViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation


protocol MainVCViewModelProtocol: NSObject {
    var articles: [Article] { get set }
    var topics: [String] { get set }
    var delegate: MainVCViewModelDelegate? { get set }
    func collectionViewDidSelectItemAt(indexPath: IndexPath)
    func getLastNews()
    func getNewsWithIndex(index: Int)
    func articlesCount() -> Int
    func topicsCount() -> Int
}
