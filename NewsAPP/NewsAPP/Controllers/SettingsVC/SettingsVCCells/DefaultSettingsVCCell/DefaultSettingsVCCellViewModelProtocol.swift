//
//  DefaultSettingsVCCellViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 28.03.22.
//

import Foundation
import UIKit


protocol DefaultSettingsVCCellViewModelProtocol: NSObject {
    func getImage() -> (image: UIImage, color: UIColor)?
    func getLabelText() -> String?
}
