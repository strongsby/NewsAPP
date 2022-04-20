//
//  SwitchSettingsCellViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 28.03.22.
//

import Foundation
import UIKit


protocol  SwitchSettingsCellViewModelProtocol: NSObject {
    var getLabelsTitle: String? { get }
    var getImage: UIImage? { get }
    var imageBackColor: UIColor? { get }
    var getSwitchPosition: Bool { get }
    func switchChangeValue(isOn: Bool) -> Void
}
