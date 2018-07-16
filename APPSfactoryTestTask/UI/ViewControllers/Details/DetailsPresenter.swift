//
//  DetailsPresenter.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 15/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

final class DetailsPresenter: ScreenPresenter {
    
    var details: DetailsPresentable?
    private let albumStorage: AlbumStorageProtocol
    
    // MARK: Initialization
    
    init(albumStorage: AlbumStorageProtocol) {
        self.albumStorage = albumStorage
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getView()?.updateTitle(title: details?.albumTitle)
        getView()?.updateAlbumImage(imageURL: details?.albumImageURL)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        synchronizeWithStorage()
    }
    
}
// MARK: DetailsPresenterProtocol

extension DetailsPresenter: DetailsPresenterProtocol {
    
    func saveAlbum() {
        guard let details = details else { return }
        
        albumStorage.add(album: details) { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success:
                self.getView()?.adjustToSavedAlbum()
                
            case .failure(let error):
                self.getView()?.show(errorMessage: error.localizedDescription)
            }
        }
    }
    
    func removeAlbum() {
        guard let albumId = details?.albumMbid else { return }
        
        albumStorage.remove(albumId: albumId) { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success:
                self.getView()?.adjustToRemovedAlbum()
                
            case .failure(let error):
                self.getView()?.show(errorMessage: error.localizedDescription)
            }
        }
    }
    
}

// MARK: Private

private extension DetailsPresenter {
    
    func getView() -> DetailsViewProtocol? {
        return view as? DetailsViewProtocol
    }
    
    func synchronizeWithStorage() {
        albumStorage.fetchAlbums { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let albums):
                if albums.contains(where: { $0.mbid == self.details?.albumMbid }) {
                    self.getView()?.adjustToSavedAlbum()
                } else {
                    self.getView()?.adjustToRemovedAlbum()
                }
                
            case .failure(let error):
                self.getView()?.show(errorMessage: error.localizedDescription)
            }
        }
    }
    
}
