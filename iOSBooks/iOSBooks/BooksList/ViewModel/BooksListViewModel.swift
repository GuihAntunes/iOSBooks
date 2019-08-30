//
//  BooksListViewModel.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 28/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import UIKit

protocol BooksListViewModelProtocol {
    func loadBooks()
    func selectBook(atIndexPath indexPath: IndexPath)
    func presentPreviousStep()
    func numberOfSections() -> Int
    func numberOfItemsInSection() -> Int
    func cellForItem(inCollectionView collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> UICollectionViewCell
}

class BooksListViewModel: BooksListViewModelProtocol {
    
    var items: [Item] = []
    var service = BooksClient()
    var startingIndex = 0
    weak var view: BooksListViewControllerPresentable?
    var selectedBook: Item?
    var coordinator: AppCoordinatorProtocol?
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection() -> Int {
        return items.count
    }
    
    func cellForItem(inCollectionView collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BooksCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(withBook: items[indexPath.item].book)
        if indexPath.item == (items.count - 1) {
            loadBooks()
        }
        return cell
    }
    
    func loadBooks() {
        service.fetchBooksList(startingIndex: startingIndex).done { [weak self] (list) in
            guard let self = self, let items = list.items else { return }
            self.items.append(contentsOf: items)
            self.startingIndex = items.count
            DispatchQueue.main.async {
                self.view?.reloadView()
            }
            }.catch { (error) in
                DispatchQueue.main.async {
                    self.view?.presentError(message: error.localizedDescription)
                }
        }
        
    }
    
    func selectBook(atIndexPath indexPath: IndexPath) {
        selectedBook = nil
        selectedBook = items[indexPath.item]
        coordinator?.presentNextStep()
    }
    
    func presentPreviousStep() {
        coordinator?.presentPreviousStep()
    }
}
