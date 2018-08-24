//
//  HomeViewController.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 12/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit
import SVProgressHUD

final class HomeViewController: UIViewController {
    
    var albumStorage: AlbumStorageProtocol?
    private var collectionViewHelper: AlbumsCollectionViewHelper?
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var placeholderLabel: UILabel!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        configureCollectionViewHelper()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAlbums()
    }
    
}

// MARK: Actions

extension HomeViewController {
    
    @IBAction func searchButtonClicked() {
        showSearch()
    }
    
}

// MARK: Private

private extension HomeViewController {
    
    func configureAppearance() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_light")!)
    }
    
    func configureCollectionViewHelper() {
        collectionViewHelper = AlbumsCollectionViewHelper(collectionView: collectionView) { [weak self] album in
            self?.showAlbum(details: album)
        }
    }
    
    func fetchAlbums() {
        albumStorage?.fetchAlbums { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let albums):
                self.collectionViewHelper?.update(albums: albums)
                self.updatePlaceholder(isHidden: !albums.isEmpty)
                
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.message)
            }
        }
    }
    
    func showSearch() {
        let identifier = SearchViewController.identifier
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: identifier) as? SearchViewController else {
            return
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlbum(details: DetailsPresentable) {
        let identifier = DetailsViewController.identifier
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: identifier) as? DetailsViewController else {
            return
        }
        
        (vc.presenter as? DetailsPresenterProtocol)?.details = details
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updatePlaceholder(isHidden: Bool) {
        placeholderLabel.isHidden = isHidden
    }
    
}
