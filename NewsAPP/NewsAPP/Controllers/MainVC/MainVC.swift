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
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            registerCollectionViewCells()
            guard let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            registerTableViewCells()
        }
    }
    private var viewModel: MainVCViewModelProtocol = MainVCViewModel()

    //MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAll()
    }
    
    //MARK: - CLASS FUNCTIONS
    
    private func registerCollectionViewCells() {
        collectionView.register(NewCollectionViewCell.defaultNib, forCellWithReuseIdentifier: NewCollectionViewCell.reuseIdentifier)
    }
    
    private func registerTableViewCells() {
        tableView.register(CustomNewsTableViewCell.defaultNib, forCellReuseIdentifier: CustomNewsTableViewCell.reuseIdentifier)
        tableView.register(NewsTableViewCell.defaultNib, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
    }
    
    private func configTitle() {
        title = "Favoriites"
    }
    
    private func bind() {
        viewModel.delegate = self
    }
    
    private func setupAll() {
        bind()
        configTitle()
        viewModel.getLastNews()
    }
}


//MARK: - EXTENSION UITableViewDelegate & SkeletonTableViewDataSource

extension MainVC: UITableViewDelegate, SkeletonTableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articlesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = viewModel.articles[indexPath.row]
        
        switch viewModel.cellStyle() {
        case true:
            let cell = tableView.dequeueReusableCells(type: CustomNewsTableViewCell.self, indexPath: indexPath)
            cell.viewModel = CustomNewsTableViewCellViewModel(article: article)
            return cell
        case false:
            let newCell = tableView.dequeueReusableCells(type: NewsTableViewCell.self, indexPath: indexPath)
            newCell.viewModel = NewsTableViewCellViewModel(article: article)
            return newCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showVC = ShowVC()
        let article = viewModel.articles[indexPath.row]
        showVC.viewModel = ShowVCViewModel.init(art: article)
        navigationController?.pushViewController(showVC, animated: true)
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch viewModel.cellStyle() {
        case true: return CustomNewsTableViewCell.reuseIdentifier
        case false: return NewsTableViewCell.reuseIdentifier
        }
    }
}


//MARK: - EXTENSION UICollectionViewDelegate & UICollectionViewDataSource

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.topicsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: NewCollectionViewCell.self, indexPath: indexPath)
        let topic = viewModel.topics[indexPath.item]
        cell.viewModel = NewCollectionViewCellViewModel.init(title: topic)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.collectionViewDidSelectItemAt(indexPath: indexPath)
    }
}


//MARK: - EXTENSION AlertHandler

extension MainVC: AlertHandler {}


//MARK: - EXTENSION MainVCViewModelDelegate

extension MainVC: MainVCViewModelDelegate {
    
    func tableViewReloadData() {
        tableView.reloadData()
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
        view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        tableView.startCustomAnimation()
    }
    
    func collectionViewReloadData() {
        collectionView.reloadData()
    }
    
    func mainVCShowAllert(title: String?, message: String?, completion: (() -> Void)?) {
        showAlert(title: title, message: message, completion: completion)
    }
}

