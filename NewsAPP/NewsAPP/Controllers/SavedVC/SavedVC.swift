//
//  SavedVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 15.03.22.
//

import UIKit
import SafariServices


final class SavedVC: UIViewController, AlertHandler {
    
    //MARK: - OUTLETS & CLASS PROPERTIES
    
    @IBOutlet private weak var addMessageView: UIView!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableViewRegisterCells()
        }
    }
    private var viewModel: SavedVCViewModelProtocol = SavedVCViewModel() 

    //MARK: - LIFE CYCLE
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupAll()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        makeTableViewIsEditingFalse()
    }
    
    //MARK: - CLASS FUNCTION
    
    private func addMessageAnimation() {
        if viewModel.arrayOfCoreDataNewsCount != 0 {
            UIView.animate(withDuration: .addMessageDuration()) { [ weak self ] in
                self?.addMessageView.alpha = .minAlpha()
            }
        } else {
            UIView.animate(withDuration: .addMessageDuration()) { [ weak self ] in
                self?.addMessageView.alpha = .maxAlpha()
            }
        }
    }
    
    private func tableViewRegisterCells() {
        tableView.register(CustomNewsTableViewCell.defaultNib, forCellReuseIdentifier: CustomNewsTableViewCell.reuseIdentifier)
        tableView.register(NewsTableViewCell.defaultNib, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
    }
    
    private func addNavigationItem() {
        let item = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(deleteDidTapped))
        navigationItem.setRightBarButton(item, animated: true)
    }
    
    private func openWithShowVC(indexPath: IndexPath) {
        let coreDataModel = viewModel.getCoreDataNews(indexPath: indexPath)
        let showVC = ShowVC(coreDataModel: coreDataModel)
        navigationController?.pushViewController(showVC, animated: true)
    }
    
    private func makeTableViewIsEditingFalse() {
        tableView.isEditing = false
    }
    
    private func configTitle() {
        title = "Saved"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func bind() {
        viewModel.delegate = self
    }
    
    private func setupAll() {
        configTitle()
        addNavigationItem()
        bind()
    }
    
    @objc func deleteDidTapped() {
        tableView.isEditing = !tableView.isEditing
    }
}


//MARK: - EXTENSION UITableViewDelegate & UITableViewDataSource

extension SavedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayOfCoreDataNewsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coreDataModel = viewModel.getCoreDataNews(indexPath: indexPath)
        
        switch viewModel.cellStyle {
        case .largeCell:
            let cell = tableView.dequeueReusableCells(type: CustomNewsTableViewCell.self, indexPath: indexPath)
            cell.viewModel = CustomNewsTableViewCellViewModel(coreDataModel: coreDataModel)
            return cell
        case .defaultCell:
            let cell = tableView.dequeueReusableCells(type: NewsTableViewCell.self, indexPath: indexPath)
            cell.viewModel = NewsTableViewCellViewModel(coreDataModel: coreDataModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openWithShowVC(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel.deleteCoreDataModel(indexPath: indexPath)
    }
}



//MARK: - EXTENSION SavedVCViewModelDelegate

extension SavedVC: SavedVCViewModelDelegate {
    
    func tableViewDeleteRowWithAnimation(indexPath: [IndexPath]) {
        tableView.deleteRows(at: indexPath, with: .left)
        addMessageAnimation()
    }
    
    func tableViewReloadData() {
        tableView.reloadData()
        addMessageAnimation()
    }
    
    func savedVCShowAlert(title: String?, message: String?, completion: (() -> Void)?) {
        showAlert(title: title, message: message, completion: completion)
    }
    
    func showInSafari(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        navigationController?.pushViewController(safariVC, animated: true)
    }
}
