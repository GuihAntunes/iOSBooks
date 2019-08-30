//
//  SalesInfo.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 28/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import Foundation

class SalesInfo: Codable {
    var country: String?
    var buyLink: String?
    
    init() {
        country = nil
        buyLink = nil
    }
}
