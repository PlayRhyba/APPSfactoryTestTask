//
//  AlbumsCollectionViewHelper.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 23/08/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit

final class AlbumsCollectionViewHelper: NSObject {
    
    typealias CellSelectionHandler = ((Album) -> Void)
    
    private struct LayoutConstants {
        
        static let horizontalSpacing: CGFloat = 25
        static let cellHeightRatio: CGFloat = 1.3
        static let topSectionSpacing: CGFloat = 26
        static let bottomSectionSpacing: CGFloat = 26
        static let lineSpacing: CGFloat = 20
        
    }
    
    private let collectionView: UICollectionView
    private let cellSelectionHandler: CellSelectionHandler?
    private var albums: [Album] = []
    
    // MARK: Initialization
    
    init(collectionView: UICollectionView,
         cellSelectionHandler: CellSelectionHandler?) {
        
        self.collectionView = collectionView
        self.cellSelectionHandler = cellSelectionHandler
        
        super.init()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.indicatorStyle = .white
    }
    
    // MARK: Public
    
    /// Update collection view with the colleciton of albums
    ///
    /// - Parameter albums: collection of albums
    func update(albums: [Album]) {
        self.albums = albums
        collectionView.reloadData()
    }
    
}

//MARK: UICollectionViewDataSource

extension AlbumsCollectionViewHelper: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = String(describing: HomeCell.self)
        let album = albums[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        (cell as? HomeCell)?.update(title: album.title,
                                    artist: album.artist,
                                    imageURL: URL(string: album.imageURL ?? ""))
        
        return cell
    }
    
}

// MARK: UICollectionViewDelegate

extension AlbumsCollectionViewHelper: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        cellSelectionHandler?(album)
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension AlbumsCollectionViewHelper: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 3 * LayoutConstants.horizontalSpacing) / 2.0
        let height = width * LayoutConstants.cellHeightRatio
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: LayoutConstants.topSectionSpacing,
                            left: LayoutConstants.horizontalSpacing,
                            bottom: LayoutConstants.bottomSectionSpacing,
                            right: LayoutConstants.horizontalSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstants.lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstants.horizontalSpacing
    }
    
}
