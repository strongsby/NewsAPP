//
//  SearchVCViewModelDelegate.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import Foundation


protocol SearchVCViewModelDelegate {
    func startAnimatedSkeletonView()
    func stopAnomatedSkeleton()
    func searchVCShowAllert(title: String?, message: String?, completion: (() -> Void)?)
    func tableViewReloadData()
}
