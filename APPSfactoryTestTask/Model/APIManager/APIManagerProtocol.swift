//
//  APIManagerProtocol.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 12/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

protocol APIManagerProtocol {
    
    /// Search artist by name
    ///
    /// - Parameters:
    ///   - name: artist's name
    ///   - completion: completion handler with collection of found artists' info
    func searchArtist(name: String,
                      completion: @escaping (OperationResult<[ArtistSearch.Artist], OperationError>) -> Void)
    
    /// Retrieve top albums of specified artist
    ///
    /// - Parameters:
    ///   - artistId: musicbrainz id for the artist
    ///   - completion: completion handler with collection of found albums
    func topAlbums(artistId: String,
                   completion: @escaping (OperationResult<[TopAlbums.Album], OperationError>) -> Void)
    
    /// Retrieve details for specified album
    ///
    /// - Parameters:
    ///   - albumId: musicbrainz id for the album
    ///   - completion: completion handler with album details
    func albumInfo(albumId: String,
                   completion: @escaping (OperationResult<AlbumInfo.Album, OperationError>) -> Void)
    
    /// Cancel all requests
    func cancel()
    
}
