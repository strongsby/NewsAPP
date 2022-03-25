//
//  ShowVCViewModelDelegate.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 24.03.22.
//

import Foundation


protocol ShowVCViewModelDelegate {
    func ShowVCShowAllert(title: String?, message: String?, complition: (() -> Void)?)
    func showInSafari(url: URL)
}
