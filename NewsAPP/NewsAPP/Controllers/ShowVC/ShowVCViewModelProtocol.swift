//
//  ShowVCViewModelProtocol.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 25.03.22.
//

import Foundation
import UIKit


protocol ShowVCViewModelProtocol: NSObject {
    var delegate: ShowVCViewModelDelegate? { get set }
    var addButtonIsHidden: Bool { get set }
    var getTitle: String? { get }
    var getDescription: String? { get }
    var getSource: String? { get }
    func saveArticle(image: UIImage?) -> Void
    func showInSafariDidTapped() -> Void
    func shareDidTapped() -> Void
    func scrollViewDidScroll(scrollView: UIScrollView)
    func setImage(downloadImageView: DownloadImageView) -> Void
}
