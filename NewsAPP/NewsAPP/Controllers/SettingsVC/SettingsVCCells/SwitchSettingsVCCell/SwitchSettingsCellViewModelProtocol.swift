//
//  SwitchSettingsCellViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 28.03.22.
//

import Foundation
import UIKit


protocol SwitchSettingsCellViewModelProtocol: NSObject {
    func getLableTitle() -> String?
    func getImage() -> (image: UIImage, color: UIColor)?
    func getSwitchPOsition() -> Bool
    func switchChangeValue(isOn: Bool) -> Void
}
