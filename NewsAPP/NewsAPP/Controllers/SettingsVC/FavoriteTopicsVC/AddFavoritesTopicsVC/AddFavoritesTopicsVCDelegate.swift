//
//  AddFavoritesTopicsVCDelegate.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 24.03.22.
//

import Foundation


protocol AddFavoritesTopicsVCDelegate {
    func dismis()
    func AddFavoritesTopicsVCShowAllert(title: String?, message: String?, complition: (() -> Void)?)
}
