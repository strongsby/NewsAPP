//
//  NewsTableViewCellViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation
import UIKit


protocol NewsTableViewCellViewModelProtocol: NSObject {
    var delegate: NewsTableViewCellViewModelDelegate? { get set }
    var getTitle: String? { get }
    var getDescription: String? { get }
    func getImage()
}
