//
//  ShowVCViewModelDelegate.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 24.03.22.
//

import Foundation
import UIKit


protocol ShowVCViewModelDelegate {
    func showVCShowActivityVC(url: URL) -> Void
    func showVCShowAlert(title: String?, message: String?, completion: (() -> Void)?)
    func showInSafari(url: URL)
    func changeImageHeightConstrain(height: CGFloat)
}
