//
//  FileManagerService.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 16.03.22.
//

import Foundation
import UIKit


final class FileManagerService {

    private let fileManagerQueue = DispatchQueue(label: "fileManagerQueue", qos: .utility)

    func save(image: UIImage, localName: String) {
        fileManagerQueue.async {
            let data = image.jpegData(compressionQuality: 1.0)

            guard let subName = localName.split(separator: "/").last else { return }
            let name = String(subName) + ".jpg"

            do {
                var directoryPath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                directoryPath.appendPathComponent(name)
                try data?.write(to: directoryPath)
                print("FileManagerService: \(#function) did save success with localName = \(localName)")
            } catch {
                print("FileManagerService: \(#function) did failed with error = \(error.localizedDescription)  localName = \(name)")
            }
        }

    }

    func loadImage(localName: String?, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            
            guard let subName = localName?.split(separator: "/").last else { return }
            
            let localName = String(subName) + ".jpg"
            
            do {
                var directoryPath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                directoryPath.appendPathComponent(localName)
                let data = try Data(contentsOf: directoryPath)

                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func deleteImage(localeName: String?) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let subName = localeName?.split(separator: "/").last else { return }
            let name = String(subName) + ".jpg"
            
            do {
                var directoryPath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                directoryPath.appendPathComponent(name)
                if FileManager.default.fileExists(atPath: directoryPath.path) {
                    try FileManager.default.removeItem(at: directoryPath)
                }
            } catch  {
                print("\(error.localizedDescription)")
            }
        }
    }
}
