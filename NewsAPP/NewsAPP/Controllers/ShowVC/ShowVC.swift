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
    @IBOutlet private weak var newsImage: UIImageView!
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
        viewModel.getImage()
    }

    private func setupScrollView() {
        scrollView.delegate = self
    }
    
    private func addEffect(_ scrollView: UIScrollView) {
        let offsetY = 250 - (scrollView.contentOffset.y )
        let minMax = max(250, offsetY)
        heightNewsImageConstraint.constant = minMax
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
        viewModel.saveArticle()
    }
    
    @IBAction func LearnMoreWithSafariDidTapped(_ sender: Any) {
        viewModel.showInSafariDidTapped()
    }
}



//MARK: - UIScrollViewDelegate

extension ShowVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        addEffect(scrollView)
    }
}


//MARK: - EXTENSION ShowVCViewModelDelegate

extension ShowVC: ShowVCViewModelDelegate {
    
    func setupImage(image: UIImage) {
        newsImage.image = image
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
