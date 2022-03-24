//
//  FavoriteTopicsVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 21.03.22.
//

import UIKit

final class FavoriteTopicsVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            registerTableViewSells()
        }
    }
    private var viewModel: FavoriteTopicsVCViewModelProtocol = FavoriteTopicsVCViewModel()
    
    private func registerTableViewSells() {
        tableView.register(FavoriteTopicsVCCell.defaultNib, forCellReuseIdentifier: FavoriteTopicsVCCell.reuseIdentifier)
    }
    
    private func bind() {
        viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    @IBAction func addButtonDidTapped() {
        let addVC = AddFavoritesTopicsVC()
        addVC.modalPresentationStyle = .formSheet
        navigationController?.present(addVC, animated: true, completion: nil)
    }
}


extension FavoriteTopicsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newTopicsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCells(type: FavoriteTopicsVCCell.self, indexPath: indexPath)
        cell.configCell(title: viewModel.newTopics[indexPath.row])
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

extension FavoriteTopicsVC: FavoriteTopicsVCViewModelDelegate {
    func tableViewReloadData() {
        tableView.reloadData()
    }
}


//
//
//import UIKit
//
//final class FavoriteTopicsVC: UIViewController {
//
//    private let userDefaultService = UserDefaultService()
//    @IBOutlet private weak var tableView: UITableView! {
//        didSet {
//            tableView.delegate = self
//            tableView.dataSource = self
//            registerTableViewSells()
//        }
//    }
//    private var newTopics: [String] = [] {
//        didSet {
//            tableView.reloadData()
//        }
//    }
//
//    private func registerTableViewSells() {
//        tableView.register(FavoriteTopicsVCCell.defaultNib, forCellReuseIdentifier: FavoriteTopicsVCCell.reuseIdentifier)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(loadAllTopics), name: NSNotification.Name("AddNewTopic"), object: nil)
//        loadAllTopics()
//    }
//
////    override func viewDidDisappear(_ animated: Bool) {
////        super.viewDidDisappear(animated)
////        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("AddNewTopic"), object: nil)
////    }
//
//    @objc func loadAllTopics() {
//        newTopics = userDefaultService.loadTopics()
//    }
//
//    @IBAction func addButtonDidTapped() {
//        let addVC = AddFavoritesTopicsVC()
//        addVC.modalPresentationStyle = .formSheet
//        navigationController?.present(addVC, animated: true, completion: nil)
//    }
//}
//
//
//extension FavoriteTopicsVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return newTopics.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCells(type: FavoriteTopicsVCCell.self, indexPath: indexPath)
//        cell.configCell(title: newTopics[indexPath.row])
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
//        return "Remove topic"
//    }
//
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        newTopics.remove(at: indexPath.row)
//        userDefaultService.saveTopics(topics: newTopics)
//        NotificationCenter.default.post(name: NSNotification.Name("AddNewTopic"), object: nil)
//    }
//}
//
//
