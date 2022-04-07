//
//  CustomHeaderView.swift
//  NewsAPP
//
//  Created by Сергей Рудинский on 6.04.22.
//

import UIKit


class CustomHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - OOTLETS & CLASS PROPERTYES

    @IBOutlet private weak var collectionView: UICollectionView! 
    private var viewModel: CustomHeaderViewViewModelProtocol = CustomHeaderViewViewModel()
    
    //MARK: - INIT
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAll()
    }
    
    //MARK: - CLASS FUNCTIONS
    
    private func bind() {
        viewModel.delegate = self
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        guard let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(NewCollectionViewCell.defaultNib, forCellWithReuseIdentifier: NewCollectionViewCell.reuseIdentifier)
    }
    
    private func setupAll() {
        setupCollectionView()
        registerCollectionViewCells()
        bind()
    }
}


//MARK: - EXTENSION UICollectionViewDelegate & UICollectionViewDataSource

extension CustomHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.topicsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: NewCollectionViewCell.self, indexPath: indexPath)
        let topic = viewModel.getTopic(indexPath: indexPath)
        cell.viewModel = NewCollectionViewCellViewModel.init(title: topic)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.collectionDidSelectItem(indexPath: indexPath)
    }
}


//MARK: - EXTENSION CustomHeaderViewViewModelDelegate

extension CustomHeaderView: CustomHeaderViewViewModelDelegate {
    func collectionViewReloadData() {
        collectionView.reloadData()
    }
}


//MAK: - EXTENSION NewsAPPNibLoadable

extension CustomHeaderView: NewsAPPNibLoadable { }
