//
//  SearchVCViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation


protocol SearchVCViewModelProtocol: NSObject {
    var newsArray: [Article] { get set }
    var delegate: SearchVCViewModelDelegate? { get set }
    func getNewsWithString(title: String?)
    func newsArrayCount() -> Int
    func cellStyle() -> Bool
    func refreshDidPull()
}
