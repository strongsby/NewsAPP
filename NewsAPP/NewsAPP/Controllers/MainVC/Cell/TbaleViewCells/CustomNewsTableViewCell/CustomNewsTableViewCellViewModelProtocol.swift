//
//  CustomNewsTableViewCellViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 31.03.22.
//

import Foundation
import UIKit


protocol CustomNewsTableViewCellViewModelProtocol: NSObject {
    func getTextForLabel() -> (title: String, description: String)
    func getImage() -> (image: UIImage?,imageURL: URL?)
    func saveImage(image: UIImage) -> Void
}
