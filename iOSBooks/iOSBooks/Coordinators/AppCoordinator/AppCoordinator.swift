//
//  AppCoordinator.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 30/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import UIKit

protocol AppCoordinatorProtocol: class {
    func presentNextStep()
    func presentPreviousStep()
}

enum RoutingState {
    case list
    case detail
}

class AppCoordinator: AppCoordinatorProtocol {
    
    lazy var injector = AppCoordinatorDependencyInjector()
    var window: UIWindow
    var state: RoutingState = .list
    
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
        injector.booksListViewModel.coordinator = self
    }
    
    func presentNextStep() {
        switch state {
        case .list:
            injector.injectNewBook()
            injector.bookDetailViewModel.coordinator = self
            state = .detail
            injector.navigationController.pushViewController(injector.bookDetailViewController, animated: true)
        case.detail:
            print("Nenhuma tela para frente neste fluxo")
        }
    }
    
    func presentPreviousStep() {
        switch state {
        case .list:
            print("Nenhuma tela para trás neste fluxo")
        case.detail:
            state = .list
            injector.navigationController.popViewController(animated: true)
        }
    }
}
