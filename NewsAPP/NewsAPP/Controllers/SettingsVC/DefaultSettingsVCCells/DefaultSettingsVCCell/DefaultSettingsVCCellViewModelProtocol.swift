//
//  DefaultSettingsVCCellViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 28.03.22.
//

import Foundation
import UIKit


protocol DefaultSettingsVCCellViewModelProtocol: NSObject {
    var getLabelText: String? { get }
    var getImage: UIImage? { get }
    var imageBackColor: UIColor? { get }
}
