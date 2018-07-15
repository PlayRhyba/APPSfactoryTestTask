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
        
        static let cellHeight: CGFloat = 50
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        (cell as? SearchCell)?.presenter = getPresenter()?.cellPresenter(at: indexPath)
        
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LayoutConstants.cellHeight
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
    
}

// MARK: Private

private extension SearchViewController {
    
    func getPresenter() -> SearchPresenterProtocol? {
        return presenter as? SearchPresenterProtocol
    }
    
    func configureAppearance() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_dark")!)
    }
    
    func configureSearchController() {
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchController.searchBar.placeholder = "Search Artists"
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = UIColor(rgb: 0xf1f1f1)

        navigationItem.titleView = self.searchController.searchBar
    }
    
}
