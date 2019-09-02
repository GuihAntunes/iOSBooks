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
    func loadSavedBooks()
    func selectBook(atIndexPath indexPath: IndexPath)
    func numberOfSections() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func cellForItem(inCollectionView collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> UICollectionViewCell
    var showFavorites: Bool { get set }
}

class BooksListViewModel: BooksListViewModelProtocol {
    
    var items: [Item] = []
    var savedItems: (books: [Item], images: [UIImage]) = ([],[])
    var service: BooksClientProtocol?
    var startingIndex = 0
    weak var view: BooksListViewControllerPresentable?
    var selectedBook: Item?
    var selectedBookIsFavorite = false
    var coordinator: AppCoordinatorProtocol?
    var showFavorites: Bool = false
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection(_ section: Int = 0) -> Int {
        return showFavorites ? savedItems.books.count : items.count
    }
    
    func cellForItem(inCollectionView collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BooksCell = collectionView.dequeueReusableCell(for: indexPath)
        let book: Book?
        var image: UIImage?
        if showFavorites {
            book = savedItems.books[indexPath.item].book
            image = savedItems.images[indexPath.item]
        } else {
            book = items[indexPath.item].book
        }
        cell.setup(withBook: book, andImage: image)
        if indexPath.item == (items.count - 1) && !showFavorites {
            loadBooks()
        }
        return cell
    }
    
    func loadSavedBooks() {
        savedItems = service?.fetchSavedBooks() ?? ([],[])
    }
    
    func loadBooks() {
        service?.fetchBooksList(startingIndex: startingIndex).done { [weak self] (list) in
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
        selectedBook = showFavorites ? savedItems.books[indexPath.item] : items[indexPath.item]
        selectedBookIsFavorite = savedItems.books.contains(where: { $0.id == selectedBook?.id })
        coordinator?.presentNextStep()
    }
}
