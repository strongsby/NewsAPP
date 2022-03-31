//
//  CustomSavedVCCellViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 30.03.22.
//

import Foundation
import UIKit


protocol CustomSavedVCCellViewModelProtocol: NSObject {
    func getTextForLables() -> (title: String, description: String)
    func getImageLocalName() -> String?
}
