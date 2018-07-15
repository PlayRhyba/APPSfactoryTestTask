//
//  DetailsProtocols.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 15/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Foundation

protocol DetailsPresentable {
    
    /// Title
    var albumTitle: String { get }
    
    /// Artist
    var albumArtist: String { get }
    
    /// Album id
    var albumMbid: String { get }
    
    /// Image URL
    var albumImageURL: URL? { get }
    
    /// Tracks
    var tracks: [String] { get }
    
}

protocol DetailsPresenterProtocol: ScreenPresenterProtocol {
    
    /// Details
    var details: DetailsPresentable { get set }
    
}

protocol DetailsViewProtocol: ScreenViewProtocol {
    
}
