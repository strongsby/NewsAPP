//
//  AddFavoritesTopicsVCDelegate.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 24.03.22.
//

import Foundation


protocol AddFavoritesTopicsVCDelegate {
    func dismiss()
    func AddFavoritesTopicsVCShowAlert(title: String?, message: String?, completion: (() -> Void)?)
}
