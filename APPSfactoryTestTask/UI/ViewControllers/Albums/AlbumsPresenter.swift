//
//  AlbumsPresenter.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 15/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Foundation

final class AlbumsPresenter: ScreenPresenter {
    
    var artist: ArtistSearch.Artist?
    private let apiManager: APIManagerProtocol
    private let albumStorage: AlbumStorageProtocol
    private var cellPresenters: [AlbumsCellPresenterProtocol] = []
    
    // MARK: Initialization
    
    init(apiManager: APIManagerProtocol,
         albumStorage: AlbumStorageProtocol) {
        self.apiManager = apiManager
        self.albumStorage = albumStorage
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getView()?.updateTitle(title: artist?.name)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        fetchAlbums()
    }
    
}

// MARK: AlbumsPresenterProtocol

extension AlbumsPresenter: AlbumsPresenterProtocol {
    
    func fetchAlbums() {
        guard cellPresenters.isEmpty else {
            syncronizeWithStorage()
            
            return
        }
        
        guard let artistId = artist?.mbid else { return }
        
        getView()?.showHUD()
        
        apiManager.topAlbums(artistId: artistId) { [weak self] result in
            guard let `self` = self else { return }
            
            self.getView()?.dismissHUD()
            
            switch result {
            case .success(let albums):
                self.cellPresenters = albums.map { AlbumsCellPresenter(album: $0) }
                self.syncronizeWithStorage()
                
            case .failure(let error):
                self.getView()?.show(errorMessage: error.localizedDescription)
            }
        }
    }
    
    func syncronizeWithStorage() {
        albumStorage.fetchAlbums { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let storedAlbums):
                self.cellPresenters.forEach { presenter in
                    presenter.isSaved = storedAlbums.contains { $0.mbid == presenter.album.mbid }
                }
                
                self.getView()?.reloadData()
                
            case .failure(let error):
                self.getView()?.show(errorMessage: error.localizedDescription)
            }
        }
    }
    
    func numberOfAlbums() -> Int {
        return cellPresenters.count
    }
    
    func cellPresenter(at indexPath: IndexPath) -> AlbumsCellPresenterProtocol? {
        return cellPresenters[indexPath.row]
    }
    
    func selectCell(at indexPath: IndexPath) {
        
    }
    
}

// MARK: Private

private extension AlbumsPresenter {
    
    func getView() -> AlbumsViewProtocol? {
        return view as? AlbumsViewProtocol
    }
    
}
