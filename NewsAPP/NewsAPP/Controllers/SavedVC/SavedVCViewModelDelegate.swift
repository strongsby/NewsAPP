//
//  SavedVCViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import Foundation


protocol SavedVCViewModelDelegate {
    func tableViewDeletRowWithAnivation(indexPath: [IndexPath])
    func tableViewReloadData()
    func savedVCShowAllert(title: String?, message: String?, completion: (() -> Void)?)
    func showInSafari(url: URL)
    func showShowVC(coreDataModel: CoreDataNews)
}
