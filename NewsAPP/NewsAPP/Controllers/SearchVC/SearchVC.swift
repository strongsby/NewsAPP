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
        let resoultVC = UIViewController()
        searchController = UISearchController(searchResultsController: resoultVC)
        searchController.searchBar.placeholder = "Search for some news"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
        //searchController.searchResultsUpdater = self        // wee can handle result here
    }
    
    private func tableViewRegisterCells() {
        tableView.register(CustomeSearchVCCell.defaultNib, forCellReuseIdentifier: CustomeSearchVCCell.reuseIdentifier)
        tableView.register(SearchVCCell.defaultNib, forCellReuseIdentifier: SearchVCCell.reuseIdentifier)
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
        return viewModel.newsArrayCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = viewModel.getArticle(indexPath: indexPath)
        
        switch viewModel.cellStyle() {
        case .largeCell:
            let cell = tableView.dequeueReusableCells(type: CustomeSearchVCCell.self, indexPath: indexPath)
            cell.viewModel = CustomeSearchVCCellViewModel(article: article)
            return cell
        case .defaultCell:
            let cell = tableView.dequeueReusableCells(type: SearchVCCell.self, indexPath: indexPath)
            cell.viewModel = SearchVCCellViewModel(article: article)
            return cell
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
        case .largeCell : return CustomeSearchVCCell.reuseIdentifier
        case .defaultCell: return SearchVCCell.reuseIdentifier
        }
    }
}


//MARK: - EXTENSION UISearchBarDelegate

extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getNewsWithString(title: searchBar.text)
        searchBar.text = nil
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
}


//MARK: - EXTENSION SearchVCViewModelDelegate

extension SearchVC: SearchVCViewModelDelegate {
    
    func endRefreshing() {
        tableView.refreshControl?.endRefreshing()
    }
    
    func refreshControlIsRefreshing() -> Bool {
        guard let refreshControl = tableView.refreshControl else { return false }
        return refreshControl.isRefreshing
    }
    
    
    func startActivityAnimated() {
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
