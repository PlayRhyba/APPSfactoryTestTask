//
//  HomeProtocols.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Foundation

protocol HomePresenterProtocol: ScreenPresenterProtocol {
    
    /// Refetch stored albums from storage
    func fetchAlbums()
    
    /// Get number of albums
    ///
    /// - Returns: number of albums
    func numberOfAlbums() -> Int
    
    /// Get presenter for album cell at index path
    ///
    /// - Parameter indexPath: index path
    /// - Returns: presenter for cell
    func cellPresenter(at indexPath: IndexPath) -> HomeCellPresenterProtocol?
    
    /// Select cell at specific index path
    ///
    /// - Parameter indexPath: index path
    func selectCell(at indexPath: IndexPath)
    
}

protocol HomeViewProtocol: ScreenViewProtocol {
    
    /// Reload view's content
    func reloadData()
    
    /// Show album details screen
    ///
    /// - Parameter details: album details info
    func showAlbum(details: DetailsPresentable)
    
}

protocol HomeCellPresenterProtocol: PresenterProtocol {
    
    /// Album
    var album: Album { get }
    
}

protocol HomeCellViewProtocol: ViewProtocol {
    
    /// Update cell's contents
    ///
    /// - Parameters:
    ///   - title: title of album
    ///   - artist: artist
    ///   - imageURL: image url
    func update(title: String?, artist: String?, imageURL: URL?)
    
}
