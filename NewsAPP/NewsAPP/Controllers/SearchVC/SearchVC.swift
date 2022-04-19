//
//  SearchVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 15.03.22.
//

import UIKit
import SkeletonView


final class SearchVC: UIViewController, AlertHandler {

    //MARK: - OUTLETS & CALASS PROPERTIES
    
    @IBOutlet private weak var activity: UIActivityIndicatorView!
    @IBOutlet private weak var addMessageView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    private var searchController: UISearchController!
    private var viewModel: SearchVCViewModelProtocol = SearchVCViewModel()
    
    //MARK: - LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAll()
    }

    //MARK: - CLASS FUNCTIONS
    
    @objc private func didPullToRefresh() {
        viewModel.refreshDidPull()
    }
    
    private func setupSearchController() {
        let resultVC = UIViewController()
        searchController = UISearchController(searchResultsController: resultVC)
        searchController.searchBar.placeholder = "Search for some news"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
        //searchController.searchResultsUpdater = self        // wee can handle result here
    }
    
    private func openWithShowVC(indexPath: IndexPath) {
        let article = viewModel.getArticle(indexPath: indexPath)
        let showVC = ShowVC(article: article)
        navigationController?.pushViewController(showVC, animated: true)
    }
    
    private func cleanSearchBar(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    private func tableViewRegisterCells() {
        tableView.register(CustomNewsTableViewCell.defaultNib, forCellReuseIdentifier: CustomNewsTableViewCell.reuseIdentifier)
        tableView.register(NewsTableViewCell.defaultNib, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
    }
    
    private func setTitle() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func bind() {
        viewModel.delegate = self
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    private func setupAll() {
        setupTableView()
        tableViewRegisterCells()
        bind()
        setupSearchController()
        setTitle()
    }
}


//MARK: - EXTENSION UITableViewDelegate & SkeletonTableViewDataSource

extension  SearchVC: UITableViewDelegate, SkeletonTableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsArrayCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = viewModel.getArticle(indexPath: indexPath)
        
        switch viewModel.cellStyle {
        case .largeCell:
            let cell = tableView.dequeueReusableCells(type: CustomNewsTableViewCell.self, indexPath: indexPath)
            cell.viewModel = CustomNewsTableViewCellViewModel(article: article)
            return cell
        case .defaultCell:
            let cell = tableView.dequeueReusableCells(type: NewsTableViewCell.self, indexPath: indexPath)
            cell.viewModel = NewsTableViewCellViewModel(article: article)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       openWithShowVC(indexPath: indexPath)
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch viewModel.cellStyle {
        case .largeCell : return CustomNewsTableViewCell.reuseIdentifier
        case .defaultCell: return NewsTableViewCell.reuseIdentifier
        }
    }
}


//MARK: - EXTENSION UISearchBarDelegate

extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getNewsWithString(title: searchBar.text)
        cleanSearchBar(searchBar)
    }
}


//MARK: - EXTENSION SearchVCViewModelDelegate

extension SearchVC: SearchVCViewModelDelegate {
    
    func endRefreshing() {
        tableView.refreshControl?.endRefreshing()
    }
    
    func startActivityAnimated() {
        guard let refreshControl = tableView.refreshControl,
        !refreshControl.isRefreshing else { return }
        activity.startAnimating()
    }
    
    func stopActivityAnimated() {
        activity.stopAnimating()
    }
    
    func addMessageShowWithAnimation() {
        UIView.animate(withDuration: .addMessageDuration()) { [ weak self ] in
            self?.addMessageView.alpha = .maxAlpha()
        }
    }
    
    func addMessageViewPutAwayWithAnimation() {
        UIView.animate(withDuration: .addMessageDuration()) { [ weak self ] in
            self?.addMessageView.alpha = .minAlpha()
        }
    }
    
    func tableViewReloadData() {
        tableView.reloadData()
        tableView.startCustomAnimation()
    }
    
    //Wee can change skeletonAnimation or activityAnimation
    
    func startAnimatedSkeletonView() {
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .systemGray), animation: nil, transition: .crossDissolve(0.25))
    }
    
    func stopAnimatedSkeleton() {
        tableView.stopSkeletonAnimation()
        view.hideSkeleton()
    }
    
    func searchVCShowAlert(title: String?, message: String?, completion: (() -> Void)?) {
        showAlert(title: title, message: message, completion: completion)
    }
}
