//
//  HomeCellPresenter.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Foundation

final class HomeCellPresenter: Presenter, HomeCellPresenterProtocol {
    
    let album: Album
    
    // MARK: Initialization
    
    init(album: Album) {
        self.album = album
    }
    
    // MARK: Presenter
    
    override func onViewAttached() {
        getView()?.update(title: album.title,
                          artist: album.artist,
                          imageURL: URL(string: album.imageURL ?? ""))
    }
    
}

// MARK: Private

private extension HomeCellPresenter {
    
    func getView() -> HomeCellViewProtocol? {
        return view as? HomeCellViewProtocol
    }
    
}
