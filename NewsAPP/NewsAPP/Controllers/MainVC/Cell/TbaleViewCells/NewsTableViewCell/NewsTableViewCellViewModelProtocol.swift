//
//  NewsTableViewCellViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation
import UIKit


protocol NewsTableViewCellViewModelProtocol: NSObject {
    func getTextForLabels() -> (title: String, description: String)
    func getImage() -> (image: UIImage?,imageURL: URL?)
    func saveImage(image: UIImage) -> Void
}
