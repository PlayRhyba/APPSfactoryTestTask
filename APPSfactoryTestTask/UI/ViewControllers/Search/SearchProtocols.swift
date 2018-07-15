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
    
    /// Clear the last search results
    func clear()
    
}

protocol SearchViewProtocol: ScreenViewProtocol {
    
    /// Reload view's content
    func reloadData()
    
    /// Dissmiss search controller
    func endSearch()
    
}

protocol SearchCellPresenterProtocol: PresenterProtocol {
    
    /// Album
    var artist: ArtistSearch.Artist { get }
    
}

protocol SearchCellViewProtocol: ViewProtocol {
    
    /// Update cell's contents
    ///
    /// - Parameters:
    ///   - payload: text payload
    ///   - imageURL: image URL
    ///   - placeholder: placeholder image
    func update(payload: NSAttributedString?,
                imageURL: URL?,
                placeholder: UIImage?)
    
}
