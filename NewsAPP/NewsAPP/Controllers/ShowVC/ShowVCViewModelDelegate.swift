//
//  ShowVCViewModelDelegate.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 24.03.22.
//

import Foundation


protocol ShowVCViewModelDelegate {
    func showVCShowActivityVC(url: URL) -> Void
    func showVCShowAllert(title: String?, message: String?, complition: (() -> Void)?)
    func showInSafari(url: URL)
}
