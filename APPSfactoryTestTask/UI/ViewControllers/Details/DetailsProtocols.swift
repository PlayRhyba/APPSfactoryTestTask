//
//  DetailsProtocols.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 15/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Foundation

protocol DetailsPresenterProtocol: ScreenPresenterProtocol {
    
    /// Details
    var details: DetailsPresentable? { get set }
    
    /// Save album
    func saveAlbum()
    
    /// Remove album
    func removeAlbum()
    
}

protocol DetailsViewProtocol: ScreenViewProtocol {
    
    /// Update view controller's title
    ///
    /// - Parameter title: title
    func update(title: String?)
    
    /// Update album image
    ///
    /// - Parameter imageURL: image URL
    func update(imageURL: URL?)
    
    /// Update album info
    ///
    /// - Parameter info: album's description
    func update(info: NSAttributedString?)
    
    /// Adjust UI to saved album state
    func adjustToSavedAlbum()
    
    /// Adjust UI to removed album state
    func adjustToRemovedAlbum()
    
    /// Transition back to previous screen
    func back()
    
}
