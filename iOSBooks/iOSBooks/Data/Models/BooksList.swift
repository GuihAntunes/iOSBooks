//
//  BooksList.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 28/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import Foundation

class BooksList: Codable {
    let items: [Item]?
    let totalItems : Int?
    
    enum CodingKeys: String, CodingKey {
        case items, totalItems
    }
}
