//
//  ShowVCViewModelDelegate.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 24.03.22.
//

import Foundation
import UIKit


protocol ShowVCViewModelDelegate {
    func setupImage(image: UIImage)
    func showVCShowActivityVC(url: URL) -> Void
    func showVCShowAlert(title: String?, message: String?, completion: (() -> Void)?)
    func showInSafari(url: URL)
}
