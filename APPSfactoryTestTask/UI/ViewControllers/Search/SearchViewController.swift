//
//  SearchViewController.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    private struct LayoutConstants {
        
        static let cellHeight: CGFloat = 77
        static let contentTopInset: CGFloat = 10
        static let contentBottomInset: CGFloat = 10
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppearance()
        configureSearchController()
    }
    
}

// MARK: IBAction

private extension SearchViewController {
    
    @IBAction func clearButtonClicked() {
        getPresenter()?.clear()
    }
    
}

// MARK: UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getPresenter()?.numberOfArtists() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath)
        (cell as? SearchCell)?.presenter = getPresenter()?.cellPresenter(at: indexPath)
        
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
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

// MARK: UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        
        getPresenter()?.search(query: query)
    }
    
}

// MARK: SearchViewProtocol

extension SearchViewController: SearchViewProtocol {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func endSearch() {
        searchController.searchBar.text = nil
        searchController.dismiss(animated: true, completion: nil)
    }
    
    func showAlbums(artist: ArtistSearch.Artist) {
        let identifier = AlbumsViewController.identifier
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: identifier) as? AlbumsViewController else {
            return
        }
        
        (vc.presenter as? AlbumsPresenterProtocol)?.artist = artist
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: Private

private extension SearchViewController {
    
    func getPresenter() -> SearchPresenterProtocol? {
        return presenter as? SearchPresenterProtocol
    }
    
    func configureAppearance() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_dark")!)
        tableView.indicatorStyle = .white
        
        tableView.contentInset = UIEdgeInsets(top: LayoutConstants.contentTopInset,
                                              left: 0,
                                              bottom: LayoutConstants.contentBottomInset,
                                              right: 0)
    }
    
    func configureSearchController() {
        definesPresentationContext = true
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchController.searchBar.placeholder = "Search Artists"
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = UIColor(hex: 0xF1F1F1)
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.black
        
        navigationItem.titleView = self.searchController.searchBar
    }
    
}
