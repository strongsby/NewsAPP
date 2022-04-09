//
//  ShowVCViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation
import UIKit


protocol ShowVCViewModelProtocol: NSObject {
    var article: Article? { get set }
    var delegate: ShowVCViewModelDelegate? { get set }
    func addButtonIsHidden() -> Bool
    func saveArticle(image: UIImage?) -> Void
    func showInSafariDidTapped() -> Void
    func shareDidTapped() -> Void
    func getCashedImage() -> UIImage?
    func getImageURL() -> URL?
    func getLablesText() -> (title: String?, description: String?, sourse: String?)
    func scrollViewDidScroll(scrollView: UIScrollView)
}
