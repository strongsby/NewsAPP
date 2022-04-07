//
//  NewsAPPNibLoadable.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 23.03.22.
//

import UIKit

protocol NewsAPPNibLoadable {
    
    static var defaultNibName: String { get }
    static func loadFromNib() -> Self
    
}

extension NewsAPPNibLoadable where Self: UIView {
    
    static var defaultNibName: String {
        return String(describing: self)
    }
    
    static var defaultNib: UINib {
        return UINib(nibName: defaultNibName, bundle: nil)
    }
    
    static func loadFromNib() -> Self {
        guard let nib = Bundle.main.loadNibNamed(defaultNibName, owner: nil, options: nil)?.first as? Self else {
            fatalError("[NewsAPPNibLoadable] Cannot load view from nib.")
        }
        return nib
    }
    
}

extension NewsAPPNibLoadable where Self: UIViewController {
    
    static var defaultNibName: String {
        return String(describing: self)
    }
    
    static var defaultNib: UINib {
        return UINib(nibName: defaultNibName, bundle: nil)
    }
    
    static func loadFromNib() -> Self {
        guard let nib = Bundle.main.loadNibNamed(defaultNibName, owner: nil, options: nil)?.first as? Self else {
            fatalError("[NewsAPPNibLoadable] Cannot load view from nib.")
        }
        return nib
    }
    
}

extension NewsAPPNibLoadable where Self: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var defaultNib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    
}


extension NewsAPPNibLoadable where Self: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var defaultNib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    
}


extension NewsAPPNibLoadable where Self: UICollectionReusableView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

}


extension NewsAPPNibLoadable where Self: UITableViewHeaderFooterView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

}
