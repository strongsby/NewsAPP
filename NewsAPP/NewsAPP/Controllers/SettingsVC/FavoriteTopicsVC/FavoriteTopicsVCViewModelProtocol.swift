//
//  FavoriteTopicsVCViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation


protocol FavoriteTopicsVCViewModelProtocol: NSObject {
    var newTopics: [String] { get set }
    var delegate: FavoriteTopicsVCViewModelDelegate? { get set }
    func newTopicsCount() -> Int
    func tbaleViewDeleteRow(indexPath: IndexPath)
}
