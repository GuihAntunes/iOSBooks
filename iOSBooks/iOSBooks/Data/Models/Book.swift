//
//  Book.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 28/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import Foundation

class Book: Codable {
    let authors: [String]?
    let title: String?
    let subtitle: String?
    let description: String?
    let imageLinks: ImageLinks?
    
    enum CodingKeys: String, CodingKey {
        case authors, title, subtitle, description, imageLinks
    }
}



