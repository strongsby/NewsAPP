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
        tableView.isEditing = false
    }
    
    //MARK: - CLASS FUNCTION
    
    private func tableViewRegisterCells() {
        tableView.register(CustomSavedVCCell.defaultNib, forCellReuseIdentifier: CustomSavedVCCell.reuseIdentifier)
        tableView.register(SavedVCCell.defaultNib, forCellReuseIdentifier: SavedVCCell.reuseIdentifier)
    }
    
    private func addNavigationItem() {
        let item = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(deleteDidTapped))
        navigationItem.setRightBarButton(item, animated: true)
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
        return viewModel.arrayOfCoreDataNewsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coreDataModel = viewModel.getCoreDataNews(indexPath: indexPath)
        
        switch viewModel.cellStyle() {
        case .largeCell:
            let cell = tableView.dequeueReusableCells(type: CustomSavedVCCell.self, indexPath: indexPath)
            cell.viewModel = CustomSavedVCCellViewModel(coreDataMode: coreDataModel)
            return cell
        case .defaultCell:
            let cell = tableView.dequeueReusableCells(type: SavedVCCell.self, indexPath: indexPath)
            cell.viewModel = SavedVCCellViewModel(coreDataMode: coreDataModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.rowDidSelect(indexPath: indexPath)
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
    
    func tableViewDeleteRowWithAnimation(indexPath: [IndexPath]) {
        tableView.deleteRows(at: indexPath, with: .left)
    }
    
    func showShowVC(coreDataModel: CoreDataNews) {
        let showVC = ShowVC()
        showVC.viewModel = ShowVCViewModel(coreDataModel: coreDataModel)
        navigationController?.pushViewController(showVC, animated: true)
    }
    
    func tableViewReloadData() {
        tableView.reloadData()
    }
    
    func savedVCShowAlert(title: String?, message: String?, completion: (() -> Void)?) {
        showAlert(title: title, message: message, completion: completion)
    }
    
    func showInSafari(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        navigationController?.pushViewController(safariVC, animated: true)
    }
}
