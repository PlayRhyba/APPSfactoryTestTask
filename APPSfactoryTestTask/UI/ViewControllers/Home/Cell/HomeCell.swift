//
//  HomeCell.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit
import AlamofireImage

final class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    // MARK: Public
    
    func update(title: String?, artist: String?, imageURL: URL?) {
        titleLabel.text = title
        artistLabel.text = artist
        
        let placeholder = UIImage(named: "ic_details_album_placeholder")
        
        guard let imageURL = imageURL else {
            imageView.image = placeholder
            
            return
        }
        
        imageView.af_setImage(withURL: imageURL, placeholderImage: placeholder)
    }
    
}

// MARK: Private

private extension HomeCell {
    
    func configureAppearance() {
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
    }
    
}
