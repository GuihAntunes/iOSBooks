//
//  BooksListViewController+View.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 30/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import UIKit

protocol BooksListViewControllerPresentable: class {
    func reloadView()
    func presentError(message: String)
}

extension BooksListViewController: BooksListViewControllerPresentable {
    func reloadView() {
        if let viewModel = viewModel {
            title = viewModel.showFavorites ? "Favorites iOS Books" : "iOS Books"
        }
        booksCollectionView?.reloadData()
    }
    
    func presentError(message: String) {
        alert(message: message)
    }
    
    func setupCollectionView()  {
        booksCollectionView?.dataSource = self
        booksCollectionView?.delegate = self
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func fillWithSavedBooks() {
        guard var viewModel = viewModel else { return }
        if !viewModel.showFavorites {
            viewModel.showFavorites.toggle()
            viewModel.loadSavedBooks(shouldShowOnScreen: true)
            return
        }
        viewModel.showFavorites.toggle()
        reloadView()
    }
    
    func setupFavoritesFilterButton() {
        navigationItem.rightBarButtonItem = button
    }
}
