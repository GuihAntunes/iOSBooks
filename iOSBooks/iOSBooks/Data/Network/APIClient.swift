//
//  APIClient.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 28/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import Foundation
import PromiseKit

enum CustomError: Error {
    case connectionError(String)
    case mappingError(String)
    case APIError(String)
    case generalError(String)
    case deallocatedClass(String)
}

class APIClient {
    
    let connectionChecker: Reachability
    let decoder: JSONDecoder
    let session: URLSession
    
    init(connectionChecker: Reachability = Reachability(), decoder: JSONDecoder = JSONDecoder(), session: URLSession = URLSession.shared) {
        self.connectionChecker = connectionChecker
        self.decoder = decoder
        self.session = session
    }
    
    func request<T: Codable>(model: T.Type, _ request: URLRequest) -> Promise<T> {
        return Promise<T> { [weak self] seal in
            guard let _self = self else {
                print("Class deinitialized!")
                return
            }
            
            guard connectionChecker.isConnected else {
                seal.reject(CustomError.connectionError("Por favor, verifique sua conexão com a internet!"))
                return
            }
            
            session.dataTask(with: request, completionHandler: { (data, response, error) in
                guard let data = data else {
                    seal.reject(CustomError.APIError(error?.localizedDescription ?? "Ocorreu um erro inesperado, por favor, tente novamente!"))
                    return
                }
                
                guard let model = try? _self.decoder.decode(T.self, from: data) else {
                    seal.reject(CustomError.mappingError("Houve um erro ao fazer o parse do modelo \(T.self)!"))
                    return
                }
                
                seal.fulfill(model)
            }).resume()
        }
    }
    
}

