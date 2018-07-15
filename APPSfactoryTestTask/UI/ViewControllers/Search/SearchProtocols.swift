//
//  SearchProtocols.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit

protocol SearchPresenterProtocol: ScreenPresenterProtocol {
    
    /// Perform search by query
    ///
    /// - Parameter query: query
    func search(query: String)
    
    /// Get number of found artists
    ///
    /// - Returns: number of found artists
    func numberOfArtists() -> Int
    
    /// Get cell presenter at index path
    ///
    /// - Parameter indexPath: index path
    /// - Returns: cell presenter
    func cellPresenter(at indexPath: IndexPath) -> SearchCellPresenterProtocol?
    
    /// Select cell at index path
    ///
    /// - Parameter indexPath: index path
    func selectCell(at indexPath: IndexPath)
    
    /// Clear the last search results
    func clear()
    
}

protocol SearchViewProtocol: ScreenViewProtocol {
    
    /// Reload view's content
    func reloadData()
    
    /// Dissmiss search controller
    func endSearch()
    
    /// Show albums list for artist with 
    ///
    /// - Parameter artist: artist
    func showAlbums(artist: ArtistSearch.Artist)
    
}

protocol SearchCellPresenterProtocol: PresenterProtocol {
    
    /// Artist
    var artist: ArtistSearch.Artist { get }
    
}

protocol SearchCellViewProtocol: ViewProtocol {
    
    /// Update cell's contents
    ///
    /// - Parameters:
    ///   - title: title
    ///   - imageURL: image URL
    func update(title: String?, imageURL: URL?)
    
}
