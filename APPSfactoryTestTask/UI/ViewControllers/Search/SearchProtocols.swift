//
//  SearchProtocols.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Foundation

protocol SearchPresenterProtocol: ScreenPresenterProtocol {
    
}

protocol SearchViewProtocol: ScreenViewProtocol {
    
    /// Reload view's content
    func reloadData()
    
}

protocol SearchCellPresenterProtocol: PresenterProtocol {
    
    /// Album
    var artist: ArtistSearch.Artist { get }
    
}

protocol SearchCellViewProtocol: ViewProtocol {
    
    /// Update cell's contents
    ///
    /// - Parameters:
    ///   - artist: artist
    ///   - imageURL: image url
    func update(artist: String?, imageURL: URL?)
    
}
