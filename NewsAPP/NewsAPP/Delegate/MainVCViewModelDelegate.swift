//
//  MainVCViewModelDelegate.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import Foundation


protocol MainVCViewModelDelegate {
    func startAnimatedSkeletonView()
    func stopAnimatedSkeletonView()
    func collectionViewReloadData()
    func mainVCShowAllert(title: String?, message: String?, completion: (() -> Void)?)
    func presentAddFavoritesTopicsVC()
}
