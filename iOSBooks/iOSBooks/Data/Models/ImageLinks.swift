//
//  ImageLinks.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 28/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import Foundation

class ImageLinks: Codable {
    let smallThumbnail: String?
    let thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case smallThumbnail, thumbnail
    }
    
}
