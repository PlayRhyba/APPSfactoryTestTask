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
                      completion: @escaping (OperationResult<[ArtistSearch.Artist], OperationError>) -> Void) {
        let request = SearchArtistRequest(name: name)
        
        requester.fetchObject(request: request) { (response: OperationResult<ArtistSearch, OperationError>) in
            switch response {
            case .success(let result):
                completion(.success(result.artists))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func topAlbums(artistId: String,
                   completion: @escaping (OperationResult<[TopAlbums.Album], OperationError>) -> Void) {
        let request = TopAlbumsRequest(mbid: artistId)
        
        requester.fetchObject(request: request) { (response: OperationResult<TopAlbums, OperationError>) in
            switch response {
            case .success(let result):
                completion(.success(result.albums))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func albumInfo(albumId: String,
                   completion: @escaping (OperationResult<AlbumInfo.Album, OperationError>) -> Void) {
        let request = AlbumInfoRequest(mbid: albumId)
        
        requester.fetchObject(request: request) { (response: OperationResult<AlbumInfo, OperationError>) in
            switch response {
            case .success(let result):
                completion(.success(result.album))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func cancel() {
        requester.cancel()
    }
    
}
