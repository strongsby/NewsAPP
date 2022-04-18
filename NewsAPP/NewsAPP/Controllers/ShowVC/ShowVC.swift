//
//  ShowVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 15.03.22.
//

import UIKit
import  SafariServices


final class ShowVC: UIViewController {
    
    //MARK: - OUTLETS & CLASS PROPETYES
    
    @IBOutlet private weak var addButton: UIButton! 
    @IBOutlet private weak var titleLabel:  UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var sourseLabel: UILabel!
    @IBOutlet private weak var newsImage: DownloadImageView!
    @IBOutlet private weak var heightNewsImageConstraint: NSLayoutConstraint!
    @IBOutlet private weak var scrollView: UIScrollView!
    var viewModel: ShowVCViewModelProtocol = ShowVCViewModel()
    
    //MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAll()
    }
    
    //MARK: - CLASS FUNCTIONS
    
    private func setupBackButton() {
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupLables() {
        let lablesText = viewModel.getLablesText()
        descriptionLabel.text = lablesText.description
        titleLabel.text = lablesText.title
        sourseLabel.text = lablesText.sourse
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

    private func setupScrollView() {
        scrollView.delegate = self
    }
    
    private func bind() {
        viewModel.delegate = self
    }
    
    private func setupAddButton() {
        addButton.isHidden = viewModel.addButtonIsHidden()
    }
    
    private func setupAll() {
        bind()
        setupBackButton()
        setupScrollView()
        setupImage()
        setupLables()
        setupAddButton()
    }
    
    //MARK: - ACTIONS
    
    @IBAction func shareDidTapped() {
        viewModel.shareDidTapped()
    }
    
    @IBAction func addDidTapped(_ sender: Any) {
        viewModel.saveArticle(image: newsImage.image)
    }
    
    @IBAction func LernMoreWithSafariDidTapped(_ sender: Any) {
        viewModel.showInSafariDidTapped()
    }
}


//MARK: - EXTENSION AlertHandler

extension ShowVC: AlertHandler {}


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
    
    func showVCShowAllert(title: String?, message: String?, complition: (() -> Void)?) {
        showAlert(title: title, message: message, completion: complition)
    }
    
    func showInSafari(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        navigationController?.pushViewController(safariVC, animated: true)
    }
}
