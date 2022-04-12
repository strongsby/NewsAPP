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
    func mainVCShowAllert(title: String?, message: String?, completion: (() -> Void)?)
    func presentAddFavoritesTopicsVC()
    func tableViewReloadData()
    func addMessageShowWithAnimation()
    func addMessageViewPutAwayWithAnimation()
    func startActivityAnimated()
    func stopActivityAnimated()
    func endRefreshing()
    func refreshControlIsRefreshing() -> Bool
}
