//
//  InfoVC.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 18.03.22.
//

import UIKit


final class InfoVC: UIViewController {
    
    //MARK: - CLASS PROPERTIES
    
    private var viewModel: InfoVCViewModelProtocol = InfoVCViewModel()
    
    //MARK: - LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
    }
    
    //MARK: - CLASS FUNCTIONS

    
    private func setupTitle() {
        title = viewModel.getText
    }
}
