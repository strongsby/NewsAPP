//
//  CustomNewsTableViewCellViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 31.03.22.
//

import Foundation
import UIKit


protocol CustomNewsTableViewCellViewModelProtocol: NSObject {
    
    var delegate: CustomNewsTableViewCellViewModelDelegate? { get set }
    var getTitle: String? { get }
    var getDescription: String? { get }
    func cancel()
    func getImage()
}
