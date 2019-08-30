//
//  AppCoordinatorDependencyInjector.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 30/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import UIKit

class AppCoordinatorDependencyInjector {
    lazy var navigationController: UINavigationController = {
        let navigation = UINavigationController()
        navigation.navigationBar.prefersLargeTitles = true
        navigation.navigationBar.barStyle = .black
        return navigation
    }()
    
    lazy var booksListViewController: BooksListViewController = {
        let controller: BooksListViewController = BooksListViewController.instantiate()
        booksListViewModel.view = controller
        controller.viewModel = booksListViewModel
        return controller
    }()
    
    lazy var booksListViewModel: BooksListViewModel = {
        return BooksListViewModel()
    }()
}
