//
//  ShowVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 15.03.22.
//

import UIKit
import  SafariServices


final class ShowVC: UIViewController, AlertHandler {
    
    //MARK: - OUTLETS & CLASS PROPERTIES
    
    @IBOutlet private weak var addButton: UIButton! 
    @IBOutlet private weak var titleLabel:  UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var newsImage: DownloadImageView!
    @IBOutlet private weak var heightNewsImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var scrollView: UIScrollView!
    var viewModel: ShowVCViewModelProtocol = ShowVCViewModel()
    
    //MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAll()
    }
    
    //MARK: - INIT
    
    convenience init(article: Article) {
        self.init()
        viewModel = ShowVCViewModel(art: article)
    }
    
    convenience init(coreDataModel: CoreDataNews) {
        self.init()
        viewModel = ShowVCViewModel(coreDataModel: coreDataModel)
    }
    
    //MARK: - CLASS FUNCTIONS
    
    private func setupBackButton() {
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupLabels() {
        descriptionLabel.text = viewModel.getDescription
        titleLabel.text = viewModel.getTitle
        sourceLabel.text = viewModel.getSource
    }
    
    private func setupImage() {
        viewModel.setImage(downloadImageView: newsImage)
    }

    private func setupScrollView() {
        scrollView.delegate = self
    }
    
    private func bind() {
        viewModel.delegate = self
    }
    
    private func setupAddButton() {
        addButton.isHidden = viewModel.addButtonIsHidden
    }
    
    private func setupAll() {
        bind()
        setupBackButton()
        setupScrollView()
        setupImage()
        setupLabels()
        setupAddButton()
    }
    
    //MARK: - ACTIONS
    
    @IBAction func shareDidTapped() {
        viewModel.shareDidTapped()
    }
    
    @IBAction func addDidTapped(_ sender: Any) {
        viewModel.saveArticle(image: newsImage.image)
    }
    
    @IBAction func LearnMoreWithSafariDidTapped(_ sender: Any) {
        viewModel.showInSafariDidTapped()
    }
}



//MARK: - UIScrollViewDelegate

extension ShowVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewModel.scrollViewDidScroll(scrollView: scrollView)
    }
}


//MARK: - EXTENSION ShowVCViewModelDelegate

extension ShowVC: ShowVCViewModelDelegate {
    
    func changeImageHeightConstrain(height: CGFloat) {
        heightNewsImageConstraint.constant = height
    }
    
    func showVCShowActivityVC(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        navigationController?.present(activityVC, animated: true, completion: nil)
    }
    
    func showVCShowAlert(title: String?, message: String?, completion: (() -> Void)?) {
        showAlert(title: title, message: message, completion: completion)
    }
    
    func showInSafari(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        navigationController?.pushViewController(safariVC, animated: true)
    }
}
