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
        static let cellHeightRatio: CGFloat = 1.3
        static let topSectionSpacing: CGFloat = 26
        static let bottomSectionSpacing: CGFloat = 26
        static let lineSpacing: CGFloat = 20
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
}

// MARK: Actions

extension HomeViewController {
    
    @IBAction func searchButtonClicked() {
        getPresenter()?.search()
    }
    
}

// MARK: HomeViewProtocol

extension HomeViewController: HomeViewProtocol {
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func showAlbum(details: DetailsPresentable) {
        let identifier = DetailsViewController.identifier
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: identifier) as? DetailsViewController else {
            return
        }
        
        (vc.presenter as? DetailsPresenterProtocol)?.details = details
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showSearch() {
        let identifier = SearchViewController.identifier
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: identifier) as? SearchViewController else {
            return
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updatePlaceholder(isHidden: Bool) {
        placeholderLabel.isHidden = isHidden
    }
}

//MARK: UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getPresenter()?.numberOfAlbums() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath)
        (cell as? HomeCell)?.presenter = getPresenter()?.cellPresenter(at: indexPath)
        
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        getPresenter()?.selectCell(at: indexPath)
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
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_light")!)
        collectionView.indicatorStyle = .white
    }
    
}
