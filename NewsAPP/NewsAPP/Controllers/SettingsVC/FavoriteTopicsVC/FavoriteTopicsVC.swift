//
//  FavoriteTopicsVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 21.03.22.
//

import UIKit

final class FavoriteTopicsVC: UIViewController {
    
    //MARK: - OUTLETS & CLASS PROPERTYES
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            registerTableViewSells()
        }
    }
    private var viewModel: FavoriteTopicsVCViewModelProtocol = FavoriteTopicsVCViewModel()
    
    //MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    //MARK: - CLASS FUNCTIONS
    
    private func registerTableViewSells() {
        tableView.register(FavoriteTopicsVCCell.defaultNib, forCellReuseIdentifier: FavoriteTopicsVCCell.reuseIdentifier)
    }
    
    private func bind() {
        viewModel.delegate = self
    }

    //MARK: - ACTIONS
    
    @IBAction func addButtonDidTapped() {
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
        return "Remove topic"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel.tbaleViewDeleteRow(indexPath: indexPath)
    }
}


//MARK: - EXTENSION FavoriteTopicsVCViewModelDelegate

extension FavoriteTopicsVC: FavoriteTopicsVCViewModelDelegate {
    func tableViewDeletRowWithAnivation(indexPath: [IndexPath]) {
        tableView.deleteRows(at: indexPath, with: .automatic)
    }
    
    
    func tableViewReloadData() {
        tableView.reloadData()
    }
}
