//
//  CustomHeaderViewViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 6.04.22.
//

import Foundation


protocol CustomHeaderViewViewModelProtocol: NSObject {
    
    var customHeaderViewDelegate: CustomHeaderViewViewModelDelegate? { get set }
    var mainVCDelegate: CustomHeaderDelegate? { get set }
    var topicsCount: Int { get }
    func getTopic(indexPath: IndexPath) -> String
    func collectionDidSelectItem(indexPath: IndexPath)
}
