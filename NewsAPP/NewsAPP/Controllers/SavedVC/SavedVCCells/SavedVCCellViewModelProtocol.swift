//
//  SavedVCCellViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 28.03.22.
//

import Foundation
import UIKit


protocol SavedVCCellViewModelProtocol: NSObject {
    func getTextForLables() -> (title: String, description: String)
    func getImageLocalName() -> String?
}
