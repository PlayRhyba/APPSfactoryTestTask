//
//  AlbumsProtocols.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 15/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit

protocol AlbumsPresenterProtocol: ScreenPresenterProtocol {
    
    /// Artist
    var artist: ArtistSearch.Artist? { get set }
    
    /// Fetch albums
    func fetchAlbums()
    
    /// Synchronize info about stored albums
    func syncronizeWithStorage()
    
    /// Get number of displaying albums
    ///
    /// - Returns: number of displaying albums
    func numberOfAlbums() -> Int
    
    /// Get cell presenter at index path
    ///
    /// - Parameter indexPath: index path
    /// - Returns: cell presenter
    func cellPresenter(at indexPath: IndexPath) -> AlbumsCellPresenterProtocol?
    
    /// Select cell at index path
    ///
    /// - Parameter indexPath: index path
    func selectCell(at indexPath: IndexPath)
    
}

protocol AlbumsViewProtocol: ScreenViewProtocol {
    
    /// Update view controller's title
    ///
    /// - Parameter title: title
    func updateTitle(title: String?)
    
    /// Reload view's content
    func reloadData()

    /// Show album details screen
    ///
    /// - Parameter details: album details info
    func showAlbum(details: DetailsPresentable)
    
}

protocol AlbumsCellPresenterProtocol: PresenterProtocol {
    
    /// Album
    var album: TopAlbums.Album { get }
    
    /// Is album saved
    var isSaved: Bool { get set }
    
}

protocol AlbumsCellViewProtocol: ViewProtocol {
    
    /// Update cell's contents
    ///
    /// - Parameters:
    ///   - title: title
    ///   - artist: artist
    ///   - imageURL: image URL
    ///   - isSaved: is album saved
    func update(title: String?,
                artist: String?,
                imageURL: URL?,
                isSaved: Bool)
    
}
