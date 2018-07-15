//
//  AlbumsViewController.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 15/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit

final class AlbumsViewController: BaseViewController {
    
    private struct LayoutConstants {
        
        static let cellHeight: CGFloat = 77
        static let contentTopInset: CGFloat = 10
        static let contentBottomInset: CGFloat = 10
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
}

// MARK: UITableViewDataSource

extension AlbumsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getPresenter()?.numberOfAlbums() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumsCell.identifier, for: indexPath)
        (cell as? AlbumsCell)?.presenter = getPresenter()?.cellPresenter(at: indexPath)
        
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension AlbumsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LayoutConstants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getPresenter()?.selectCell(at: indexPath)
    }
    
}

// MARK: AlbumsViewProtocol

extension AlbumsViewController: AlbumsViewProtocol {
    
    func updateTitle(title: String?) {
        self.title = title
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showAlbumInfo(albumId: String) { //!!!
        
        // TODO: Transition to album details
        
    }
    
}

// MARK: Private

private extension AlbumsViewController {
    
    func getPresenter() -> AlbumsPresenterProtocol? {
        return presenter as? AlbumsPresenterProtocol
    }
    
    func configureAppearance() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_dark")!)
        tableView.indicatorStyle = .white
        
        tableView.contentInset = UIEdgeInsets(top: LayoutConstants.contentTopInset,
                                              left: 0,
                                              bottom: LayoutConstants.contentBottomInset,
                                              right: 0)
    }
    
}

