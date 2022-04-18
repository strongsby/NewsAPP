//
//  TableView+Reusable.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import UIKit


extension UITableView {
    
    func dequeueReusableCells<CellType: UITableViewCell>(type: CellType.Type, indexPath: IndexPath) -> CellType {
        return self.dequeueReusableCell(withIdentifier: "\(CellType.self)", for: indexPath) as! CellType
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(type: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: "\(T.self)") as! T
    }
}
