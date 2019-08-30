//
//  BookDetailViewModel.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 30/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import Foundation

protocol BookDetailViewModelProtocol {
    func getBookTitle() -> String
    func getBookAuthors() -> String
    func getBookBuyLink() -> String
    func getBookDescription() -> String
    func getBookImageLink() -> URL?
    func presentPreviousStep()
    func getScreenTitle() -> String?
    func getBookBuyLinkURL() -> URL?
}

class BookDetailViewModel: BookDetailViewModelProtocol {
    
    // MARK: - Properties
    var selectedBook: Item?
    weak var view: BookDetailViewControllerPresentable?
    var coordinator: AppCoordinatorProtocol?
    
    // MARK: - ViewModel Protocol Methods
    func getBookTitle() -> String {
        guard let bookTitle = selectedBook?.book?.title else { return "Título indisponível" }
        var title = "Título: "
        title.append(bookTitle)
        return title
    }
    
    func getBookAuthors() -> String {
        guard let bookAuthor = selectedBook?.book?.authors?.first else { return "Autores não disponíveis" }
        var author = "Autor: "
        author.append(bookAuthor)
        return author
    }
    
    func getBookBuyLink() -> String {
        return selectedBook?.salesInfo?.buyLink ?? "Link de compra não disponível"
    }
    
    func getBookDescription() -> String {
        return selectedBook?.book?.description ?? "Sem descrição disponível"
    }
    
    func getBookImageLink() -> URL? {
        if let bookURLString = selectedBook?.book?.imageLinks?.thumbnail {
            return URL(string: bookURLString)
        }
        
        return nil
    }
    
    func getScreenTitle() -> String? {
        return selectedBook?.book?.title
    }
    
    func presentPreviousStep() {
        coordinator?.presentPreviousStep()
    }
    
    func getBookBuyLinkURL() -> URL? {
        if let urlString = selectedBook?.salesInfo?.buyLink {
            return URL(string: urlString)
        }
        
        return nil
    }
}
