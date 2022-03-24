//
//  ShowVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 15.03.22.
//

import UIKit
import  SafariServices





final class ShowVC: UIViewController {
    
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var titleLabel:  UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var sourseLabel: UILabel!
    @IBOutlet private weak var newsImage: DownloadImageView!
    var viewModel: ShowVCViewModelProtocol = ShowVCViewModel()
    
    private func setupLables() {
        let lablesText = viewModel.getLablesText()
        descriptionLabel.text = lablesText.description
        titleLabel.text = lablesText.title
        sourseLabel.text = "Sourse: \(lablesText.sourse)"
    }
    
    private func setupImage() {
        if let image = viewModel.getCashedImage() {
            newsImage.image = image
        } else if let url = viewModel.getImageURL() {
            newsImage.load(url) { [ weak self ] image in
                self?.newsImage.image = image
            }
        }
    }

    private func bind() {
        viewModel.delegate = self
    }
    
    private func setupAll() {
        bind()
        setupImage()
        setupLables()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAll()
    }
    
    @IBAction func addDidTapped(_ sender: Any) {
        viewModel.saveArticle(image: newsImage.image)
    }
    
    @IBAction func LernMoreWithSafariDidTapped(_ sender: Any) {
        viewModel.showInSafariDidTapped()
    }
}


extension ShowVC: AlertHandler {}


extension ShowVC: ShowVCViewModelDelegate {
    func ShowVCShowAllert(title: String?, message: String?, complition: (() -> Void)?) {
        showAlert(title: title, message: message, completion: complition)
    }
    
    func showInSafari(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        navigationController?.pushViewController(safariVC, animated: true)
    }
    
    
}




//final class ShowVC: UIViewController {
//
//    @IBOutlet private weak var addButton: UIButton!
//    @IBOutlet private weak var titleLabel:  UILabel!
//    @IBOutlet private weak var descriptionLabel: UILabel!
//    @IBOutlet private weak var sourseLabel: UILabel!
//    @IBOutlet private weak var newsImage: DownloadImageView!
//    private let fileManagerService = FileManagerService()
//    var article: Article?
//
//    func configShowVC() {
//        if let title = article?.title, let description = article?.content, let sourse = article?.source?.name {
//            descriptionLabel.text = description
//            titleLabel.text = title
//            sourseLabel.text = "Sourse: \(sourse)"
//        }
//        guard let urlToImage = article?.urlToImage else { return }
//        if let image = ImageCacheService.shared.load(urlToImage: urlToImage) {
//            newsImage.image = image
//        } else {
//            guard let url = URL(string: urlToImage) else { return }
//            newsImage.load(url) { [ weak self ] image in
//                self?.newsImage.image = image
//            }
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configShowVC()
//    }
//
//    @IBAction func addDidTapped(_ sender: Any) {
//        self.showAlert(title: "Sorry", message: "are you sure you want to save this news") { [ weak self ] in
//            guard let article = self?.article else { return }
//            guard let tryAdd = article.addCoreDataNews(), tryAdd else {
//                self?.showAlert(title: "Sorry", message: "Failed to save Data") {}
//                return
//            }
//            if let localName = article.urlToImage, let url = URL(string: localName) {
//                let dounloadImage = DownloadImageView()
//                dounloadImage.load(url) { [ weak self ] image in
//                    self?.fileManagerService.save(image: image, localName: localName)
//                }
//            }
//            CoreDataService.shared.saveContext()
//        }
//    }
//
//    @IBAction func LernMoreWithSafariDidTapped(_ sender: Any) {
//        guard let urlstr = article?.url, let url = URL(string: urlstr) else { return }
//        let safariVC = SFSafariViewController(url: url)
//        navigationController?.pushViewController(safariVC, animated: true)
//    }
//}
//
//
//extension ShowVC: AlertHandler {}
