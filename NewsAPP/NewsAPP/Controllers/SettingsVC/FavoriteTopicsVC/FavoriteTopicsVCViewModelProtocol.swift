//
//  FavoriteTopicsVCViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation


protocol FavoriteTopicsVCViewModelProtocol: NSObject {
    var delegate: FavoriteTopicsVCViewModelDelegate? { get set }
    var newTopicsCount: Int { get }
    func tableViewDeleteRow(indexPath: IndexPath)
    func getTopic(indexPath: IndexPath) -> String
}
