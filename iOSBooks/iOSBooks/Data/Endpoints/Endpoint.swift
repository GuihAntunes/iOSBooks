//
//  Endpoint.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 28/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var httpMethod: String { get }
    var request: URLRequest { get }
    var queryItems: [URLQueryItem]? { get }
}
