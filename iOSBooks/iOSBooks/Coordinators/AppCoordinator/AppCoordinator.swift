//
//  AppCoordinator.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 30/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    lazy var injector = AppCoordinatorDependencyInjector()
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        setupNavigationController()
        window.rootViewController = injector.navigationController
        window.makeKeyAndVisible()
    }
    
    func setupNavigationController() {
        injector.navigationController.viewControllers.append(injector.booksListViewController)
    }
}
