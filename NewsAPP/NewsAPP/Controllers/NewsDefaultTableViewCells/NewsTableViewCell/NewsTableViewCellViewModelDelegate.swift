//
//  NewsTableViewCellViewModelDelegate.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 20.04.22.
//

import Foundation
import UIKit


protocol NewsTableViewCellViewModelDelegate {
    
    func setupImage(image: UIImage)
    func loadImage(url: URL, completion: @escaping ((UIImage) -> Void))
}