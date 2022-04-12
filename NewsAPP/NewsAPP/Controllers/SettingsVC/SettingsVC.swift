//
//  SettingsVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 17.03.22.
//

import UIKit


final class SettingsVC: UIViewController {
    
    //MARK: - OUTLETS & CLASS PROPERTYES
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableViewRegisterCells()
        }
    }
    var viewModel: SettingsVCViewModelProtocol = SettingsVCViewModel()
    
    //MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAll()
    }
    
    //MARK: - CLASS FUNCTIONS
    
    private func tableViewRegisterCells() {
        tableView.register(DefaultSettingsVCCell.defaultNib, forCellReuseIdentifier: DefaultSettingsVCCell.reuseIdentifier)
        tableView.register(SwitchSettingsCell.defaultNib, forCellReuseIdentifier: SwitchSettingsCell.reuseIdentifier)
    }
    
    private func setTitle() {
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func bind() {
        viewModel.delegate = self
    }
    
    private func setupAll() {
        setTitle()
        bind()
    }
}


//MARK: - EXTENSION UITableViewDelegate & UITableViewDataSource

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.settingsArrayTitleForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return viewModel.settingsArrayTitleForFooterInSection(section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.settingsArrayCounr()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settingsArrayOptionsCount(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.getSettingsType(indexPath: indexPath)
        
        switch model {
        case .DefaultSettingsVCCell(defaultModel: let defaultSettingsModel):
            let cell = tableView.dequeueReusableCells(type: DefaultSettingsVCCell.self, indexPath: indexPath)
            cell.viewModel = DefaultSettingsVCCellViewModel(model: defaultSettingsModel)
            return cell
        case .SwitchSettingsOptions(switchModel: let switchSettingsModel):
            let cell = tableView.dequeueReusableCells(type:  SwitchSettingsCell.self, indexPath: indexPath)
            cell.viewModel = SwitchSettingsCellViewModel(model: switchSettingsModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewDidSelectRowAT(indexPath: indexPath)
    }
}


//MARK: - EXTENSION SettingsVCViewModelDelegate

extension SettingsVC: SettingsVCViewModelDelegate {
    
    func showSettingsVC() {
        navigationController?.pushViewController(VisualSettingsVC(), animated: true)
    }
    
    func showFavoriteTopicsVC() {
        navigationController?.pushViewController(FavoriteTopicsVC(), animated: true)
    }
    
    func showInfoVC() {
        navigationController?.pushViewController(InfoVC(), animated: true)
    }
}

