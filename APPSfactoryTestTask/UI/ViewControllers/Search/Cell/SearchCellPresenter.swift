//
//  SearchCellPresenter.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 15/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit

final class SearchCellPresenter: Presenter, SearchCellPresenterProtocol {
    
    let artist: ArtistSearch.Artist
    
    // MARK: Initialization
    
    init(artist: ArtistSearch.Artist) {
        self.artist = artist
    }
    
    // MARK: Presenter
    
    override func viewDidAttach() {
        super.viewDidAttach()
        
        getView()?.update(title: artist.name,
                          imageURL: artist.image.imageURL(size: .medium))
    }
    
}

// MARK: Private

private extension SearchCellPresenter {
    
    func getView() -> SearchCellViewProtocol? {
        return view as? SearchCellViewProtocol
    }
    
}
