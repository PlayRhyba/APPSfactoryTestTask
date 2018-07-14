//
//  HomePresenter.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Foundation

final class HomePresenter: ScreenPresenter {
    
    let albumStorage: AlbumStorageProtocol
    var cellPresenters: [HomeCellPresenterProtocol] = []
    
    // MARK: Initialization
    
    init(albumStorage: AlbumStorageProtocol) {
        self.albumStorage = albumStorage
    }
    
    // MARK: Lifecycle
    
    override func viewWillAppear() {
        super.viewWillAppear()
        fetchAlbums()
    }
    
}

// MARK: HomePresenterProtocol

extension HomePresenter: HomePresenterProtocol {
    
    func fetchAlbums() {
        albumStorage.fetchAlbums { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let albums):
                self.cellPresenters = albums.map { HomeCellPresenter(album: $0) }
                self.getView()?.reloadData()
                
            case .failure(let error):
                self.getView()?.show(errorMessage: error.localizedDescription)
            }
        }
    }
    
    func numberOfAlbums() -> Int {
        return cellPresenters.count
    }
    
    func cellPresenter(at indexPath: IndexPath) -> HomeCellPresenterProtocol? {
        return cellPresenters[indexPath.row]
    }
    
}

// MARK: Private

private extension HomePresenter {
    
    func getView() -> HomeViewProtocol? {
        return view as? HomeViewProtocol
    }
    
}
