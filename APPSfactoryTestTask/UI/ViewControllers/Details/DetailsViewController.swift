//
//  DetailsViewController.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 15/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit
import AlamofireImage

final class DetailsViewController: BaseViewController {
    
    private struct Constants {
        
        static let barButtonItemTintColor = UIColor(hex: 0x9A4B6F)
        
    }
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var artistImage: UIImageView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
}

// MARK: DetailsViewProtocol

extension DetailsViewController: DetailsViewProtocol {
    
    func updateTitle(title: String?) {
        self.title = title
    }
    
    func updateAlbumImage(imageURL: URL?) {
        let placeholder = UIImage(named: "ic_details_album_placeholder")
        
        guard let imageURL = imageURL else {
            backgroundImageView.image = nil
            artistImage.image = placeholder
            
            return
        }
        
        backgroundImageView.af_setImage(withURL: imageURL)
        artistImage.af_setImage(withURL: imageURL, placeholderImage: placeholder)
    }
    
    func adjustToSavedAlbum() {
        DispatchQueue.main.async {
            let item = UIBarButtonItem(barButtonSystemItem: .trash,
                                       target: self,
                                       action: #selector(self.removeAlbum))
            
            item.tintColor = Constants.barButtonItemTintColor
            
            self.navigationItem.rightBarButtonItem = item
        }
    }
    
    func adjustToRemovedAlbum() {
        DispatchQueue.main.async {
            let item = UIBarButtonItem(barButtonSystemItem: .add,
                                       target: self,
                                       action: #selector(self.saveAlbum))
            
            item.tintColor = Constants.barButtonItemTintColor
            
            self.navigationItem.rightBarButtonItem = item
        }
    }
    
}

// MARK: Actions

private extension DetailsViewController {
    
    @objc func saveAlbum() {
        getPresenter()?.saveAlbum()
    }
    
    @objc func removeAlbum() {
        getPresenter()?.removeAlbum()
    }
    
}

// MARK: Private

private extension DetailsViewController {
    
    func getPresenter() -> DetailsPresenterProtocol? {
        return presenter as? DetailsPresenterProtocol
    }
    
    func configureAppearance() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_dark")!)
        
        artistImage.layer.masksToBounds = true
        artistImage.layer.cornerRadius = 5
    }
    
}
