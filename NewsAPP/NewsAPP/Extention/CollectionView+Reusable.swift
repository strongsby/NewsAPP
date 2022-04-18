//
//  CollectionView+Reusable.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<CellType: UICollectionViewCell>(type: CellType.Type, indexPath: IndexPath) -> CellType {
        return dequeueReusableCell(withReuseIdentifier: "\(CellType.self)", for: indexPath) as! CellType
    }
}

