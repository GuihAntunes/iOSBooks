//
//  BooksListViewController.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 28/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import UIKit

class BooksListViewController: UIViewController {

    // MARK: - Properties
    var viewModel: BooksListViewModelProtocol?
    @IBOutlet weak var booksCollectionView: UICollectionView?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        setupCollectionView()
        viewModel?.loadBooks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
}
