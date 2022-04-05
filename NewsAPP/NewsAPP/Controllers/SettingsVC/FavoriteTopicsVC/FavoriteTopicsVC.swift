//
//  FavoriteTopicsVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 21.03.22.
//

import UIKit

final class FavoriteTopicsVC: UIViewController {
    
    //MARK: - OUTLETS & CLASS PROPERTYES
    
    @IBOutlet private weak var addMessageView: UIView! 
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            registerTableViewSells()
        }
    }
    private var viewModel: FavoriteTopicsVCViewModelProtocol = FavoriteTopicsVCViewModel()
    
    //MARK: - LIFE CYCLE
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupAll()
    }
    
    //MARK: - CLASS FUNCTIONS
    
    private func setupAll() {
        setupTitle()
        setupNavigationItem()
        bind()
    }
    
    private func registerTableViewSells() {
        tableView.register(FavoriteTopicsVCCell.defaultNib, forCellReuseIdentifier: FavoriteTopicsVCCell.reuseIdentifier)
    }
    
    private func setupTitle() {
        title = "Favorite topics"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func bind() {
        viewModel.delegate = self
    }
    
    private func setupNavigationItem() {
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDidTapped))
        navigationItem.setRightBarButton(item, animated: true)
    }
    
    @objc func addDidTapped() {
        let addVC = AddFavoritesTopicsVC()
        addVC.modalPresentationStyle = .formSheet
        navigationController?.present(addVC, animated: true, completion: nil)
    }
}


//MARK: - EXTENSION UITableViewDelegate & UITableViewDataSource

extension FavoriteTopicsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newTopicsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCells(type: FavoriteTopicsVCCell.self, indexPath: indexPath)
        let newTopicTitle = viewModel.newTopics[indexPath.row]
        cell.viewModel = FavoriteTopicsVCCellViewModel(titleText: newTopicTitle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel.tbaleViewDeleteRow(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All added topics"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "You can remove topics by dragging it to the left or add it by clicking the plus sign"
    }
}


//MARK: - EXTENSION FavoriteTopicsVCViewModelDelegate

extension FavoriteTopicsVC: FavoriteTopicsVCViewModelDelegate {
    
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
    
    func tableViewDeletRowWithAnivation(indexPath: [IndexPath]) {
        tableView.deleteRows(at: indexPath, with: .left)
    }
    
    
    func tableViewReloadData() {
        tableView.reloadData()
    }
}
