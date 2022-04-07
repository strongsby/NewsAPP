//
//  CustomHeaderViewViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 6.04.22.
//

import Foundation


protocol CustomHeaderViewViewModelProtocol: NSObject {
    var delegate: CustomHeaderViewViewModelDelegate? { get set }
    func topicsCount() -> Int
    func getTopic(indexPath: IndexPath) -> String
    func collectionDidSelectItem(indexPath: IndexPath)
}
