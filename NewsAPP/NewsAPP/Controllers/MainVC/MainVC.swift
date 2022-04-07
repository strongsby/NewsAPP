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
    
    @IBOutlet private weak var addMessageView: UIView!
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
    
    private func registerTableViewCells() {
        tableView.register(CustomHeaderView.defaultNib, forHeaderFooterViewReuseIdentifier: CustomHeaderView.reuseIdentifier)    // reuseIdentifire
        tableView.register(CustomNewsTableViewCell.defaultNib, forCellReuseIdentifier: CustomNewsTableViewCell.reuseIdentifier)
        tableView.register(NewsTableViewCell.defaultNib, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
    }
    
    private func configTitle() {
        title = "Favoriites"
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(type: CustomHeaderView.self)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articlesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = viewModel.getArticle(indexPath: indexPath)
        
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
        let article = viewModel.getArticle(indexPath: indexPath)
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


//MARK: - EXTENSION AlertHandler

extension MainVC: AlertHandler {}


//MARK: - EXTENSION MainVCViewModelDelegate

extension MainVC: MainVCViewModelDelegate {
    
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
        view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        tableView.startCustomAnimation()
    }
    
    func mainVCShowAllert(title: String?, message: String?, completion: (() -> Void)?) {
        showAlert(title: title, message: message, completion: completion)
    }
}
