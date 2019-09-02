//
//  Book.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 28/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import Foundation

class Book: Codable {
    var authors: [String]?
    var title: String?
    var subtitle: String?
    var description: String?
    var imageLinks: ImageLinks?
    
    init() {
        authors = nil
        title = nil
        subtitle = nil
        description = nil
        imageLinks = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case authors, title, subtitle, description, imageLinks
    }
}



