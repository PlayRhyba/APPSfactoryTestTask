//
//  DetailsPresenter.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 15/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit

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
        
        getView()?.update(title: details?.albumTitle)
        getView()?.update(imageURL: details?.albumImageURL)
        getView()?.update(info: albumInfo)
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
            
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.getView()?.adjustToSavedAlbum()
                    
                case .failure(let error):
                    self.getView()?.show(errorMessage: error.localizedDescription)
                }
            }
        }
    }
    
    func removeAlbum() {
        guard let albumId = details?.albumMbid else { return }
        
        albumStorage.remove(albumId: albumId) { [weak self] result in
            guard let `self` = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.getView()?.back()
                    
                case .failure(let error):
                    self.getView()?.show(errorMessage: error.localizedDescription)
                }
            }
        }
    }
    
}

// MARK: Private

private extension DetailsPresenter {
    
    var albumInfo: NSAttributedString? {
        let info = NSMutableAttributedString()
        
        let centerAlignmentParagraphStyle = NSMutableParagraphStyle()
        centerAlignmentParagraphStyle.alignment = .center
        
        if let title = details?.albumTitle {
            let titlePart = NSAttributedString(string: title + "\n",
                                               attributes: [.font: UIFont.boldSystemFont(ofSize: 24),
                                                            .foregroundColor: UIColor.white,
                                                            .paragraphStyle: centerAlignmentParagraphStyle])
            info.append(titlePart)
        }
        
        if let artist = details?.albumArtist {
            let artistPart = NSAttributedString(string: artist + "\n",
                                                attributes: [.font: UIFont.systemFont(ofSize: 22),
                                                             .foregroundColor: UIColor(hex: 0xFFC128),
                                                             .paragraphStyle: centerAlignmentParagraphStyle])
            info.append(artistPart)
        }
        
        if let tracks = details?.albumTracks,
            !tracks.isEmpty {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            
            let numberedTracks = tracks
                .enumerated()
                .map { (index, track) in "\(index + 1). \(track)" }
                .joined(separator: "\n")
            
            let tracksPart = NSAttributedString(string: "\n" + numberedTracks,
                                                attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                             .foregroundColor: UIColor(white: 1, alpha: 0.75),
                                                             .paragraphStyle: paragraphStyle])
            info.append(tracksPart)
        }
        
        return info
    }
    
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
