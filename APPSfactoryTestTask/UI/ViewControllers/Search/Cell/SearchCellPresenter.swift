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
    
    override func onViewAttached() {
        let payload = NSAttributedString(string: artist.name,
                                         attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13),
                                                      NSAttributedStringKey.foregroundColor: UIColor.white])
        getView()?.update(payload: payload,
                          imageURL: artist.image.imageURL(size: .medium),
                          placeholder: nil) //!!!
    }
    
}

// MARK: Private

private extension SearchCellPresenter {
    
    func getView() -> SearchCellViewProtocol? {
        return view as? SearchCellViewProtocol
    }
    
}
