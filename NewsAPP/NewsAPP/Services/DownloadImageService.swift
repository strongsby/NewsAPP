//
//  DownloadImageService.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 21.04.22.
//

import Foundation
import UIKit


final class DownloadImageService {
        
    private var downloadTask: DispatchWorkItem?
    
    func load(_ url: URL?, completion: @escaping (UIImage) -> Void) {
        guard let url = url else { return }
        
        let downloadTask = DispatchWorkItem(qos: .userInitiated, block: {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
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
    }
}
