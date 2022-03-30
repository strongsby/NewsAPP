//
//  TableView+Animation.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 29.03.22.
//

import Foundation
import UIKit


extension UITableView {
    func startCustomAnimation() {
        let cells = visibleCells
        let tableViewHeight = bounds.height
        var delay = 0.0
        
        cells.forEach { cell in
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
            
            UIView.animate(withDuration: 1.0,
                           delay: delay * 0.05,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: { cell.transform = CGAffineTransform.identity },
                           completion: nil)
            delay += 1
        }
    }
}
