//
//  AddFavoritesTopicsVCProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation


protocol AddFavoritesTopicsVCProtocol: NSObject {
    var delegate: AddFavoritesTopicsVCDelegate? { get set }
    func addDidTapped(topic: String?) -> Bool
}
