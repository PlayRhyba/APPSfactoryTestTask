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
    
    @IBOutlet weak var payloadLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    
}

// MARK: SearchCellViewProtocol

extension SearchCell: SearchCellViewProtocol {
    
    func update(payload: NSAttributedString?,
                imageURL: URL?,
                placeholder: UIImage?) {
        payloadLabel.attributedText = payload
        
        guard let imageURL = imageURL else {
            albumImage.image = placeholder
            
            return
        }
        
        albumImage.af_setImage(withURL: imageURL, placeholderImage: placeholder)
    }
    
}
