//
//  DownloadImageView.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 14.03.22.
//

import UIKit

final class DownloadImageView: UIImageView {
    
    var imageURL: URL?
    
    private var downloadTask: DispatchWorkItem?
    
    func load(_ url: URL?, completion: @escaping (UIImage) -> Void) {
        guard let url = url else { return }
        imageURL = url
                
        let downloadTask = DispatchWorkItem(qos: .userInitiated, block: {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data),
               self.imageURL == url {
                DispatchQueue.main.async { [weak self] in
                        self?.image = image
                        completion(image)
                    }
                }
            })
        DispatchQueue.global(qos: .userInitiated).async(execute: downloadTask)
        self.downloadTask = downloadTask
    }
    
    func cancel() {
        downloadTask?.cancel()
        downloadTask = nil
        image = UIImage(named: "defaultImage")
    }
    
}
