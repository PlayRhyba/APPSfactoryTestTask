//
//  AlbumsCell.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 15/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit
import AlamofireImage

final class AlbumsCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var storedAlbumImage: UIImageView!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
}

// MARK: AlbumsCellViewProtocol

extension AlbumsCell: AlbumsCellViewProtocol {
    
    func update(title: String?,
                artist: String?,
                imageURL: URL?,
                isSaved: Bool) {
        titleLabel.text = title
        artistLabel.text = artist
        storedAlbumImage.isHidden = !isSaved
        
        let placeholder = UIImage(named: "ic_albums_album_placeholder")
        
        guard let imageURL = imageURL else {
            albumImage.image = placeholder
            
            return
        }
        
        albumImage.af_setImage(withURL: imageURL, placeholderImage: placeholder)
    }
    
}

// MARK: Private

private extension AlbumsCell {
    
    func configureAppearance() {
        albumImage.layer.masksToBounds = true
        albumImage.layer.cornerRadius = 3
        
        containerView.layer.cornerRadius = 3
    }
    
}

