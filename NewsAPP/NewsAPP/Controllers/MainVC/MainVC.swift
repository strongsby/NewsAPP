//
//  MainVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 12.03.22.
//




// Прыгаю изображения

import UIKit
import SkeletonView



final class MainVC: UIViewController {
    
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

    
    private func registerCollectionViewCells() {
        collectionView.register(NewCollectionViewCell.defaultNib, forCellWithReuseIdentifier: NewCollectionViewCell.reuseIdentifier)
    }
    
    private func registerTableViewCells() {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAll()
    }
}


extension MainVC: UITableViewDelegate, SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articlesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCells(type: NewsTableViewCell.self, indexPath: indexPath)
        newCell.configCell(article: viewModel.articles[indexPath.row])
        return newCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showVC = ShowVC()
        let article = viewModel.articles[indexPath.row]
        showVC.viewModel = ShowVCViewModel.init(art: article)
       // showVC.article = viewModel.articles[indexPath.row]
        navigationController?.pushViewController(showVC, animated: true)
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return NewsTableViewCell.reuseIdentifier
    }
}


extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.topicsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: NewCollectionViewCell.self, indexPath: indexPath)
        cell.configCell(title: viewModel.topics[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.collectionViewDidSelectItemAt(indexPath: indexPath)
    }
}


extension MainVC: AlertHandler {}


extension MainVC: MainVCViewModelDelegate {
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
    }
    
    func collectionViewReloadData() {
        collectionView.reloadData()
    }
    
    func mainVCShowAllert(title: String?, message: String?, completion: (() -> Void)?) {
        showAlert(title: title, message: message, completion: completion)
    }
}



//
//
//import UIKit
//import SkeletonView
//
//
//
//final class MainVC: UIViewController {
//    
//    @IBOutlet private weak var collectionView: UICollectionView! {
//        didSet {
//            collectionView.delegate = self
//            collectionView.dataSource = self
//            registerCollectionViewCells()
//            guard let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
//            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        }
//    }
//    @IBOutlet private weak var tableView: UITableView! {
//        didSet {
//            tableView.delegate = self
//            tableView.dataSource = self
//            registerTableViewCells()
//        }
//    }
//    private var netwokService = NetwokService()
//    private var userDefaultService = UserDefaultService()
//    private var articles: [Article] = []
//    private var topics: [String] = [] {
//        didSet {
//            collectionView.reloadData()
//        }
//    }
//    
//    
//    private func registerCollectionViewCells() {
//        collectionView.register(NewCollectionViewCell.defaultNib, forCellWithReuseIdentifier: NewCollectionViewCell.reuseIdentifier)
//    }
//    
//    private func registerTableViewCells() {
//        tableView.register(NewsTableViewCell.defaultNib, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
//    }
//    
//    private func getLastNews() {
//        startAnimatedSkeletonView()
//        netwokService.getLatsNews { [ weak self ] result in
//            switch result {
//            case .failure(let error):
//                self?.stopAnimatedSkeletonView()
//                self?.showAlert(title: "Sorry", message: "\(error.localizedDescription)", completion: nil)
//                print(error)
//            case .success(let news):
//                self?.stopAnimatedSkeletonView()
//                self?.articles = news
//            }
//        }
//    }
//    
//    private func getNewsWithIndex(index: Int) {
//        startAnimatedSkeletonView()
//        let needTopic = topics[index]
//        netwokService.serchNews(for: needTopic) { [ weak self ] result in
//            switch result {
//            case .failure(let error):
//                self?.stopAnimatedSkeletonView()
//                self?.showAlert(title: "Sorry", message: error.localizedDescription, completion: nil)
//            case .success(let articles):
//                self?.stopAnimatedSkeletonView()
//                self?.articles = articles
//            }
//        }
//    }
//    
//    private func startAnimatedSkeletonView() {
//        tableView.isSkeletonable = true
//        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .systemGray4), animation: nil, transition: .crossDissolve(0.25))
//    }
//    
//    private func stopAnimatedSkeletonView() {
//        tableView.stopSkeletonAnimation()
//        view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
//    }
//    
//    private func configTitle() {
//        title = "Favoriites"
//    }
//    
//    private func addObserver() {
//        
//    }
//    
//    private func setupAll() {
//        getLastNews()
//        configTitle()
//        updateTopics()
//        NotificationCenter.default.addObserver(self, selector: #selector(updateTopics), name: NSNotification.Name("AddNewTopic"), object: nil)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupAll()
//    }
//    
//    @objc private func updateTopics() {
//        topics = ["+", "Last"] + userDefaultService.loadTopics()
//    }
//}
//
//
//extension MainVC: UITableViewDelegate, SkeletonTableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return articles.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let newCell = tableView.dequeueReusableCells(type: NewsTableViewCell.self, indexPath: indexPath)
//        newCell.configCell(article: articles[indexPath.row])
//        return newCell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let showVC = ShowVC()
//        showVC.article = articles[indexPath.row]
//        navigationController?.pushViewController(showVC, animated: true)
//    }
//    
//    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
//        return NewsTableViewCell.reuseIdentifier
//    }
//}
//
//
//extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return topics.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(type: NewCollectionViewCell.self, indexPath: indexPath)
//        cell.configCell(title: topics[indexPath.item])
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch indexPath.item {
//        case 0:
//            navigationController?.present(AddFavoritesTopicsVC(), animated: true, completion: nil)
//        case 1:
//            getLastNews()
//        default:
//            getNewsWithIndex(index: indexPath.item)
//        }
//    }
//}
//
//
//extension MainVC: AlertHandler {}
