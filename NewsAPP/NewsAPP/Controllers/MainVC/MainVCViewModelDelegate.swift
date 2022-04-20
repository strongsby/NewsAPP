//
//  MainVCViewModelDelegate.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import Foundation


protocol MainVCViewModelDelegate {
    func mainVCShowAlert(title: String?, message: String?, completion: (() -> Void)?)
    func presentAddFavoritesTopicsVC()
    func tableViewReloadData()
}
