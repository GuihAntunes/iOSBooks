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
    
    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchBooksList() -> Promise<BooksList> {
        return apiClient.request(model: BooksList.self, BooksAPI.list(startingIndex: 0).request)
    }
}
