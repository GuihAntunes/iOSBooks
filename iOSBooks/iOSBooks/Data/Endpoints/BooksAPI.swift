//
//  BooksAPI.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 28/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import Foundation

enum BooksAPI: Endpoint {
    
    case list(startingIndex: Int)
    
    var path: String {
        switch self {
        case .list:
            return "https://www.googleapis.com/books/v1/volumes"
        }
    }
    
    var startingIndex: Int {
        switch self {
        case .list(let index):
            return index
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .list:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .list:
            return nil
        }
    }
    
    var httpMethod: String {
        switch self {
        case .list:
            return "GET"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .list:
            let subjectItem = URLQueryItem(name: "q", value: "ios")
            let maxResultsItem = URLQueryItem(name: "maxResults", value: "20")
            let startIndexItem = URLQueryItem(name: "startIndex", value: String(startingIndex))
            return [subjectItem, startIndexItem, maxResultsItem]
        }
    }
    
    var request: URLRequest {
        switch self {
        case .list:
            guard var components = URLComponents(string: path) else { fatalError() }
            components.queryItems = queryItems
            guard let url = components.url else { fatalError() }
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = headers
            request.httpMethod = httpMethod
            request.httpBody = body
            return request
        }
    }
}

