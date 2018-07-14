//
//  HomeViewController.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 12/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    private struct LayoutConstants {
        
        static let horizontalSpacing: CGFloat = 25
        static let cellHeightRatio: CGFloat = 1.27
        static let topSectionSpacing: CGFloat = 26
        static let bottomSectionSpacing: CGFloat = 9
        static let lineSpacing: CGFloat = 20
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
}

// MARK: HomeViewProtocol

extension HomeViewController: HomeViewProtocol {
    
    func reloadData() {
        collectionView.reloadData()
    }
    
}

//MARK: UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getPresenter()?.numberOfAlbums() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath)
        (cell as? HomeCell)?.presenter = getPresenter()?.cellPresenter(at: indexPath)
        
        return cell
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
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

// MARK: Private

private extension HomeViewController {
    
    func getPresenter() -> HomePresenterProtocol? {
        return presenter as? HomePresenterProtocol
    }
    
    func configureAppearance() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_home")!)
    }
    
}
