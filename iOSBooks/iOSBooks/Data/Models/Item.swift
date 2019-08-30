//
//  Item.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 28/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import Foundation

class Item: Codable {
    var id: String?
    var book: Book?
    var salesInfo : SalesInfo?
    
    init() {
        id = nil
        book = nil
        salesInfo = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case book = "volumeInfo"
        case id
        case salesInfo = "saleInfo"
    }
}
