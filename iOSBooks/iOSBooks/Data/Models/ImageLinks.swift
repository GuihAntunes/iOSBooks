//
//  ImageLinks.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 28/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import Foundation

class ImageLinks: Codable {
    var smallThumbnail: String?
    var thumbnail: String?
    
    init() {
        smallThumbnail = nil
        thumbnail = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case smallThumbnail, thumbnail
    }
    
}
