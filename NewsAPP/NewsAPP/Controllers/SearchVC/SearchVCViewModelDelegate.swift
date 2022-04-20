//
//  SearchVCViewModelDelegate.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import Foundation


protocol SearchVCViewModelDelegate {
    func searchVCShowAlert(title: String?, message: String?, completion: (() -> Void)?)
    func tableViewReloadData()
}
