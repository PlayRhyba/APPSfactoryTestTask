//
//  SearchCell.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 15/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit
import AlamofireImage

final class SearchCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
}

// MARK: SearchCellViewProtocol

extension SearchCell: SearchCellViewProtocol {
    
    func update(title: String?, imageURL: URL?) {
        titleLabel.text = title
        
        let placeholder = UIImage(named: "ic_artist_placeholder")
        
        guard let imageURL = imageURL else {
            artistImage.image = placeholder
            
            return
        }
        
        artistImage.af_setImage(withURL: imageURL, placeholderImage: placeholder)
    }
    
}

// MARK: Private

private extension SearchCell {
    
    func configureAppearance() {
        artistImage.layer.masksToBounds = true
        artistImage.layer.cornerRadius = 3

        containerView.layer.cornerRadius = 3
    }
    
}
