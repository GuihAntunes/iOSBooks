//
//  BooksListViewController.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 28/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import UIKit

class BooksListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var booksCollectionView: UICollectionView?

    // MARK: - Properties
    var viewModel: BooksListViewModelProtocol?
    lazy var button = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(fillWithSavedBooks))
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupFavoritesFilterButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        viewModel?.loadSavedBooks()
        viewModel?.showFavorites = false
        viewModel?.loadBooks()
    }
}
