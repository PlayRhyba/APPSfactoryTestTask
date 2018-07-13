//
//  APIManager.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 12/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

final class APIManager {
    
    let requester: RequesterProtocol
    
    // MARK: Initialization
    
    init(requester: RequesterProtocol) {
        self.requester = requester
    }
    
}

// MARK: APIManagerProtocol

extension APIManager: APIManagerProtocol {
    
    func searchArtist(name: String,
                      completion: @escaping (Response<[Artist], ResponseError>) -> Void) {
        let request = SearchArtistRequest(name: name)
        
        requester.fetchObject(request: request) { (response: Response<ArtistSearchResponse, ResponseError>) in
            switch response {
            case .success(let result):
                completion(.success(result.artists))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
