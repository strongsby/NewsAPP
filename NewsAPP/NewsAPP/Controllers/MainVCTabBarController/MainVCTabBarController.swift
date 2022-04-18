//
//  MainVCTabBarController.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 18.04.22.
//

import UIKit

class MainVCTabBarController: UITabBarController {

    //MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    //MARK: - CLASS FUNCTIONS
    
    private func setupTabBarController() {
        let mainVC = MainVC()
        mainVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1)
        let navigationController = UINavigationController(rootViewController: mainVC)
        
        let searchVC = SearchVC()
        let navigationController2 = UINavigationController(rootViewController: searchVC)
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        
        let savedVC = SavedVC()
        let navigationController3 = UINavigationController(rootViewController: savedVC)
        savedVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 3)
        
        let settingsVC = SettingsVC()
        let navigationController4 = UINavigationController(rootViewController: settingsVC)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), tag: 4)
        
        viewControllers = [navigationController, navigationController2, navigationController3, navigationController4]
    }
}
