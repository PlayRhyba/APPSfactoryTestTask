//
//  AlbumStorageProtocol.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 13/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Foundation

protocol AlbumStorageProtocol {
    
    /// Fetch stored albums
    ///
    /// - Parameters:
    ///   - sortDescriptor: sort descriptor
    ///   - completion: completion handler
    func fetchAlbums(sortDescriptor: NSSortDescriptor,
                     completion: @escaping (OperationResult<[Album], OperationError>) -> Void)
    
    /// Add album to storage
    ///
    /// - Parameters:
    ///   - album: album
    ///   - completion: completion handler
    func add(album: AlbumInfo.Album,
             completion: @escaping (OperationResult<Album, OperationError>) -> Void)
    
    /// Remove album from storage
    ///
    /// - Parameters:
    ///   - albumId: musicbrainz id for the album
    ///   - completion: completion handler
    func remove(albumId: String,
                completion: @escaping (OperationResult<Void, OperationError>) -> Void)
    
}

extension AlbumStorageProtocol {
    
    func fetchAlbums(completion: @escaping (OperationResult<[Album], OperationError>) -> Void) {
        fetchAlbums(sortDescriptor: NSSortDescriptor.albumsSortDescriptor, completion: completion)
    }
    
}
