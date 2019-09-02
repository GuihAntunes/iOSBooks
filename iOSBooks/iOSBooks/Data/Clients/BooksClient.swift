//
//  BooksClient.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 28/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import Foundation
import PromiseKit

class BooksClient {
    
    let apiClient: APIClient
    let coreDataClient: CoreDataClient
    
    init(apiClient: APIClient = APIClient(), coreData: CoreDataClient = CoreDataClient()) {
        self.apiClient = apiClient
        self.coreDataClient = coreData
    }
    
    func fetchBooksList(startingIndex index: Int) -> Promise<BooksList> {
        return apiClient.request(model: BooksList.self, BooksAPI.list(startingIndex: index).request)
    }
    
    func fetchSavedBooks() -> (books: [Item], images: [UIImage]) {
        return coreDataClient.fetchAllSavedBooks()
    }
    
}
