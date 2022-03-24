//
//  SavedVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 15.03.22.
//

import UIKit
import SafariServices
import CoreData

final class SavedVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableViewRegisterCells()
        }
    }
    private var viewModel: SavedVCViewModelProtocol = SavedVCViewModel()

    private func tableViewRegisterCells() {
        tableView.register(SavedVCCell.defaultNib, forCellReuseIdentifier: SavedVCCell.reuseIdentifier)
    }
    
    private func addNavigationItem() {
        let item = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(deletDidTapped))
        navigationItem.setRightBarButton(item, animated: true)
    }
    
    private func configTitle() {
        title = "Favoriites"
    }
    
    private func bind() {
        viewModel.delegate = self
    }
    
    private func setupAll() {
        configTitle()
        addNavigationItem()
        bind()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAll()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tableView.isEditing = false 
    }
    
    @objc func deletDidTapped() {
        tableView.isEditing = !tableView.isEditing
    }
}


extension SavedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arryOfCoreDataNewsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCells(type: SavedVCCell.self, indexPath: indexPath)
        cell.configCell(article: viewModel.arryOfCoreDataNews[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.rowDidSelect(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove new"
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel.deletCoreDataModel(indexPath: indexPath)
    }
}


extension SavedVC: AlertHandler {}



extension SavedVC: SavedVCViewModelDelegate {
    
    func tableViewReloadData() {
        tableView.reloadData()
    }
    
    func savedVCShowAllert(title: String?, message: String?, completion: (() -> Void)?) {
        showAlert(title: title, message: message, completion: completion)
    }
    
    func showInSafari(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        navigationController?.pushViewController(safariVC, animated: true)
    }
}