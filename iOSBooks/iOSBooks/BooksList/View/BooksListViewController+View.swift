//
//  BooksListViewController+View.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 30/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import UIKit

protocol BooksListViewControllerPresentable {
    func reloadView()
    func presentError(message: String)
}

extension BooksListViewController: BooksListViewControllerPresentable {
    func reloadView() {
        booksCollectionView?.reloadData()
    }
    
    func presentError(message: String) {
        alert(message: message)
    }
    
    func setupCollectionView()  {
        title = "iOS Books"
        booksCollectionView?.dataSource = self
        booksCollectionView?.delegate = self
    }
}
