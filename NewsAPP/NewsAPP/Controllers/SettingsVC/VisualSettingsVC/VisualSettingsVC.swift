//
//  VisualSettingsVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 11.04.22.
//

import UIKit


final class VisualSettingsVC: UIViewController {
    
    //MARK: - OUTLETS & CLASS PROPERTIES
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableViewRegisterCells()
        }
    }
    var viewModel: VisualSettingsVCViewModelProTocol = VisualSettingsVCViewModel()
    
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
        title = "Visual Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupAll() {
        setTitle()
    }
}


//MARK: - EXTENSION UITableViewDelegate & UITableViewDataSource

extension VisualSettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.settingsArrayTitleForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return viewModel.settingsArrayTitleForFooterInSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settingsArrayOptionsCount
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
}

