//
//  FavoriteTopicsVCViewModelDelegate?.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 24.03.22.
//

import Foundation


protocol FavoriteTopicsVCViewModelDelegate {
    func tableViewReloadData()
    func tableViewDeletRowWithAnivation(indexPath: [IndexPath])
    func addMessageShowWithAnimation()
    func addMessageViewPutAwayWithAnimation()
}
