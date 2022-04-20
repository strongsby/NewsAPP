//
//  SavedVCViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import Foundation


protocol SavedVCViewModelDelegate {
    func tableViewDeleteRowWithAnimation(indexPath: [IndexPath])
    func tableViewReloadData()
    func savedVCShowAlert(title: String?, message: String?, completion: (() -> Void)?)
    func showInSafari(url: URL)
}
