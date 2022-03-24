//
//  SettingsVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 17.03.22.
//

import UIKit

final class SettingsVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableViewRegisterCells()
        }
    }
    private var viewModel: SettingsVCViewModelProtocol = SettingsVCViewModel()
    
    private func tableViewRegisterCells() {
        tableView.register(DefaultSettingsVCCell.defaultNib, forCellReuseIdentifier: DefaultSettingsVCCell.reuseIdentifier)
        tableView.register(SwitchSettingsCell.defaultNib, forCellReuseIdentifier: SwitchSettingsCell.reuseIdentifier)
    }
    
    private func setTitle() {
        title = "Settings"
    }
    
    private func bind() {
        viewModel.delegate = self
    }
    
    private func setupAll() {
        setTitle()
        bind()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAll()
    }
}


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
        let model = viewModel.settingsArray[indexPath.section].options[indexPath.row]
        
        switch model {
        case .DefaultSettingsVCCell(defaultModel: let defaultSettings):
            let cell = tableView.dequeueReusableCells(type: DefaultSettingsVCCell.self, indexPath: indexPath)
            cell.cofigCell(model: defaultSettings)
            return cell
        case .SwitchSettingsOptions(switchModel: let switchSettinggs):
            let cell = tableView.dequeueReusableCells(type: SwitchSettingsCell.self, indexPath: indexPath)
            cell.configCell(model: switchSettinggs)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableViewDidSelectRowAT(indexPath: indexPath)
    }
}


extension SettingsVC: SettingsVCViewModelDelegate {
    func showFavoriteTopicsVC() {
        navigationController?.pushViewController(FavoriteTopicsVC(), animated: true)
    }
    
    func showInfoVC() {
        navigationController?.pushViewController(InfoVC(), animated: true)
    }
    
    
}






//
//
//
//
//import UIKit
//
//final class SettingsVC: UIViewController {
//
//    @IBOutlet private weak var tableView: UITableView! {
//        didSet {
//            tableView.delegate = self
//            tableView.dataSource = self
//            tableViewRegisterCells()
//        }
//    }
//    private var settingsArray: [SettingsSection] {
//        let array: [SettingsSection] = [
//            SettingsSection(headerTitle: "Visual settings", footerTitle: "In these settings, you can change the color scheme of the program",
//                            options: [SettingsOptionsType.SwitchSettingsOptions(switchModel: SwitchSettingsOptions(imageBackgroundColor: UIColor.green, title: "Dark mode", settingsImage: UIImage(systemName: "switch.2"))) ]),
//
//            SettingsSection(headerTitle: "General settings", footerTitle: "In these settings, you can change the main elements of the program",
//                            options: [SettingsOptionsType.DefaultSettingsVCCell(defaultModel: DefaultSettingsOptions(imageBackgroundColor: .purple, title: "Favorite topics", settingsImage: UIImage(systemName: "star.leadinghalf.fill")))]),
//
//            SettingsSection(headerTitle: "Information", footerTitle: "These settings contain all information about the application, including the API",
//                            options: [SettingsOptionsType.DefaultSettingsVCCell(defaultModel: DefaultSettingsOptions(imageBackgroundColor: .link, title: "info", settingsImage: UIImage(systemName: "info.circle")))])
//        ]
//        return array
//    }
//
//    private func tableViewRegisterCells() {
//        tableView.register(DefaultSettingsVCCell.defaultNib, forCellReuseIdentifier: DefaultSettingsVCCell.reuseIdentifier)
//        tableView.register(SwitchSettingsCell.defaultNib, forCellReuseIdentifier: SwitchSettingsCell.reuseIdentifier)
//    }
//
//    private func setTitle() {
//        title = "Settings"
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setTitle()
//    }
//}
//
//
//extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//        case 0: return settingsArray[0].headerTitle
//        case 1: return settingsArray[1].headerTitle
//        case 2: return settingsArray[2].headerTitle
//        default: return "Ups"
//        }
//    }
//
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        switch section {
//        case 0: return settingsArray[0].footerTitle
//        case 1: return settingsArray[1].footerTitle
//        case 2: return settingsArray[2].footerTitle
//        default: return "Ups"
//        }
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return settingsArray.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0: return settingsArray[0].options.count
//        case 1: return settingsArray[1].options.count
//        case 2: return settingsArray[2].options.count
//        default: return 0
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let model = settingsArray[indexPath.section].options[indexPath.row]
//
//        switch model {
//        case .DefaultSettingsVCCell(defaultModel: let defaultSettings):
//            let cell = tableView.dequeueReusableCells(type: DefaultSettingsVCCell.self, indexPath: indexPath)
//            cell.cofigCell(model: defaultSettings)
//            return cell
//        case .SwitchSettingsOptions(switchModel: let switchSettinggs):
//            let cell = tableView.dequeueReusableCells(type: SwitchSettingsCell.self, indexPath: indexPath)
//            cell.configCell(model: switchSettinggs)
//            return cell
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.section {
//        case 1: navigationController?.pushViewController(FavoriteTopicsVC(), animated: true)
//        case 2: navigationController?.pushViewController(InfoVC(), animated: true)
//        default: break
//        }
//    }
//}
