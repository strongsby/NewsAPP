//
//  MainVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 12.03.22.
//

import UIKit
import SkeletonView


final class MainVC: UIViewController {
    
    //MARK: - OUTLETS & CLASS PROPERTYES
    
    @IBOutlet private weak var activity: UIActivityIndicatorView!
    @IBOutlet private weak var addMessageView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    private var viewModel: MainVCViewModelProtocol = MainVCViewModel()

    //MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAll()
    }
    
    //MARK: - CLASS FUNCTIONS
    
    @objc private func didPullToRefresh() {
        viewModel.refreshDidPull()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    private func registerTableViewCells() {
        tableView.register(CustomHeaderView.defaultNib, forHeaderFooterViewReuseIdentifier: CustomHeaderView.reuseIdentifier)    // reuseIdentifire
        tableView.register(CustomNewsTableViewCell.defaultNib, forCellReuseIdentifier: CustomNewsTableViewCell.reuseIdentifier)
        tableView.register(NewsTableViewCell.defaultNib, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
    }
    
    private func configTitle() {
        title = "Most Recent"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func bind() {
        viewModel.delegate = self
    }
    
    private func setupAll() {
        setupTableView()
        registerTableViewCells()
        bind()
        configTitle()
        viewModel.getLastNews()
    }
}


//MARK: - EXTENSION UITableViewDelegate & SkeletonTableViewDataSource

extension MainVC: UITableViewDelegate, SkeletonTableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(type: CustomHeaderView.self)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articlesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = viewModel.getArticle(indexPath: indexPath)
        
        switch viewModel.cellStyle() {
        case .largeCell:
            let cell = tableView.dequeueReusableCells(type: CustomNewsTableViewCell.self, indexPath: indexPath)
            cell.viewModel = CustomNewsTableViewCellViewModel(article: article)
            return cell
        case .defaultCell:
            let newCell = tableView.dequeueReusableCells(type: NewsTableViewCell.self, indexPath: indexPath)
            newCell.viewModel = NewsTableViewCellViewModel(article: article)
            return newCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showVC = ShowVC()
        let article = viewModel.getArticle(indexPath: indexPath)
        showVC.viewModel = ShowVCViewModel.init(art: article)
        navigationController?.pushViewController(showVC, animated: true)
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch viewModel.cellStyle() {
        case .largeCell: return CustomNewsTableViewCell.reuseIdentifier
        case .defaultCell: return NewsTableViewCell.reuseIdentifier
        }
    }
}


//MARK: - EXTENSION AlertHandler

extension MainVC: AlertHandler {}


//MARK: - EXTENSION MainVCViewModelDelegate

extension MainVC: MainVCViewModelDelegate {
    
    func refreshControlIsRefreshing() -> Bool {
        guard let refreschControl = tableView.refreshControl else { return false }
        return refreschControl.isRefreshing
    }
    
    func endRefreshing() {
        tableView.refreshControl?.endRefreshing()
    }
    
    func startActivityAnimated() {
        activity.startAnimating()
    }
    
    func stopActivityAnimated() {
        activity.stopAnimating()
    }
    
    func addMessageShowWithAnimation() {
        UIView.animate(withDuration: .addMessgeDuration()) { [ weak self ] in
            self?.addMessageView.alpha = .maxAlpha()
        }
    }
    
    func addMessageViewPutAwayWithAnimation() {
        UIView.animate(withDuration: .addMessgeDuration()) { [ weak self ] in
            self?.addMessageView.alpha = .minAlpha()
        }
    }
    
    func tableViewReloadData() {
        tableView.reloadData()
        tableView.startCustomAnimation()
    }
    
    func presentAddFavoritesTopicsVC() {
        navigationController?.present(AddFavoritesTopicsVC(), animated: true, completion: nil)
    }
    
    func startAnimatedSkeletonView() {
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .systemGray4), animation: nil, transition: .crossDissolve(0.25))
    }
    
    func stopAnimatedSkeletonView() {
        tableView.stopSkeletonAnimation()
        view.hideSkeleton()
    }
    
    func mainVCShowAllert(title: String?, message: String?, completion: (() -> Void)?) {
        showAlert(title: title, message: message, completion: completion)
    }
}
