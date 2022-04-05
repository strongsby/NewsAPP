//
//  SearchVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 15.03.22.
//

import UIKit
import SkeletonView

final class SearchVC: UIViewController {

    //MARK: - OUTLETS & CALASS PROPERTYES
    
    @IBOutlet private weak var addMessageView: UIView!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableViewRegisterCells()
        }
    }
    private var searcController: UISearchController!
    private var viewModel: SearchVCViewModelProtocol = SearchVCViewModel()
    
    //MARK: - LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAll()
    }

    //MARK: - CLASS FUNCTIONS
    
    private func setupSearchController() {
        let resoultVC = UIViewController()
        //resoultVC.view.backgroundColor = .systemGray       // for test
        searcController = UISearchController(searchResultsController: resoultVC)
        searcController.searchBar.placeholder = "Search for some news"
        navigationItem.searchController = searcController
        navigationItem.hidesSearchBarWhenScrolling = true
        searcController.searchBar.delegate = self
        //searcController.searchResultsUpdater = self        // i can handle result here
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
    
    private func setupAll() {
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
        let article = viewModel.newsArray[indexPath.row]
        
        switch viewModel.cellStyle() {
        case true:
            let cell = tableView.dequeueReusableCells(type: CustomeSearchVCCell.self, indexPath: indexPath)
            cell.viewModel = CustomeSearchVCCellViewModel(article: article)
            return cell
        case false:
            let cell = tableView.dequeueReusableCells(type: SearchVCCell.self, indexPath: indexPath)
            cell.viewModel = SearchVCCellViewModel(article: article)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showVC = ShowVC()
        let article = viewModel.newsArray[indexPath.row]
        showVC.viewModel = ShowVCViewModel.init(art: article)
        navigationController?.pushViewController(showVC, animated: true)
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch viewModel.cellStyle() {
        case true : return CustomeSearchVCCell.reuseIdentifier
        case false: return SearchVCCell.reuseIdentifier
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


//MARK: - EXTENSION AlertHandler

extension SearchVC: AlertHandler {}


//MARK: - EXTENSION SearchVCViewModelDelegate

extension SearchVC: SearchVCViewModelDelegate {
    
    func addMessageShowWithAnimation() {
        UIView.animate(withDuration: 0.7) { [ weak self ] in
            self?.addMessageView.alpha = 1.0
        }
    }
    
    func addMessageViewPutAwayWithAnimation() {
        UIView.animate(withDuration: 0.7) { [ weak self ] in
            self?.addMessageView.alpha = 0
        }
    }
    
    func tableViewReloadData() {
        tableView.reloadData()
    }
    
    func startAnimatedSkeletonView() {
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .systemGray), animation: nil, transition: .crossDissolve(0.25))
    }
    
    func stopAnomatedSkeleton() {
        tableView.stopSkeletonAnimation()
        view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        tableView.startCustomAnimation()
    }
    
    func searchVCShowAllert(title: String?, message: String?, completion: (() -> Void)?) {
        showAlert(title: title, message: message, completion: completion)
    }
}
