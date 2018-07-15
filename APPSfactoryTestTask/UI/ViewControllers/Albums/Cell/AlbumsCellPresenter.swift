//
//  AlbumsCellPresenter.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 15/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit

final class AlbumsCellPresenter: Presenter, AlbumsCellPresenterProtocol {
    
    let album: TopAlbums.Album
    var isSaved = false
    
    // MARK: Initialization
    
    init(album: TopAlbums.Album) {
        self.album = album
    }
    
    // MARK: Presenter
    
    override func viewDidAttach() {
        super.viewDidAttach()
        
        getView()?.update(title: album.name,
                          artist: album.artist.name,
                          imageURL: album.image?.imageURL(size: .medium),
                          isSaved: isSaved)
    }
    
}

// MARK: Private

private extension AlbumsCellPresenter {
    
    func getView() -> AlbumsCellViewProtocol? {
        return view as? AlbumsCellViewProtocol
    }
    
}
