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
    func loadSavedBooks(shouldShowOnScreen reloadView: Bool)
    func selectBook(atIndexPath indexPath: IndexPath)
    func presentPreviousStep()
    func numberOfSections() -> Int
    func numberOfItemsInSection() -> Int
    func cellForItem(inCollectionView collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> UICollectionViewCell
    var showFavorites: Bool { get set }
}

class BooksListViewModel: BooksListViewModelProtocol {
    
    var items: [Item] = []
    var savedItems: [Item] = []
    var service = BooksClient()
    var startingIndex = 0
    weak var view: BooksListViewControllerPresentable?
    var selectedBook: Item?
    var selectedBookIsFavorite = false
    var coordinator: AppCoordinatorProtocol?
    var showFavorites: Bool = false
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection() -> Int {
        return showFavorites ? savedItems.count : items.count
    }
    
    func cellForItem(inCollectionView collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BooksCell = collectionView.dequeueReusableCell(for: indexPath)
        let book: Book?
        if showFavorites {
            book = savedItems[indexPath.item].book
        } else {
            book = items[indexPath.item].book
        }
        cell.setup(withBook: book)
        if indexPath.item == (items.count - 1) && !showFavorites {
            loadBooks()
        }
        return cell
    }
    
    func loadSavedBooks(shouldShowOnScreen reloadView: Bool = false) {
        savedItems = service.fetchSavedBooks()
        if reloadView {
            view?.reloadView()
        }
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
        selectedBook = showFavorites ? savedItems[indexPath.item] : items[indexPath.item]
        selectedBookIsFavorite = savedItems.contains(where: { $0.id == selectedBook?.id })
        coordinator?.presentNextStep()
    }
    
    func presentPreviousStep() {
        coordinator?.presentPreviousStep()
    }
}
