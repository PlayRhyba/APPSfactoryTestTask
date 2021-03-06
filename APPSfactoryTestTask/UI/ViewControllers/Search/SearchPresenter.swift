//
//  SearchPresenter.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Foundation

final class SearchPresenter: ScreenPresenter {
    
    private let apiManager: APIManagerProtocol
    private var cellPresenters: [SearchCellPresenterProtocol] = []
    
    // MARK: Initialization
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
    // MARK: Lifecycle
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        
        apiManager.cancel()
        getView()?.endSearch()
    }
    
}

// MARK: SearchPresenterProtocol

extension SearchPresenter: SearchPresenterProtocol {
    
    func search(query: String) {
        getView()?.showHUD()
        
        apiManager.searchArtist(name: query) { [weak self] result in
            guard let `self` = self else { return }
            
            self.getView()?.dismissHUD()
            
            switch result {
            case .success(let artists):
                self.cellPresenters = artists.map { SearchCellPresenter(artist: $0) }
                self.getView()?.endSearch()
                self.getView()?.reloadData()
                
            case .failure(let error):
                if case OperationError.canceled = error {} else {
                    self.getView()?.show(errorMessage: error.localizedDescription)
                }
            }
        }
        
    }
    
    func numberOfArtists() -> Int {
        return cellPresenters.count
    }
    
    func cellPresenter(at indexPath: IndexPath) -> SearchCellPresenterProtocol? {
        return cellPresenters[indexPath.row]
    }
    
    func selectCell(at indexPath: IndexPath) {
        let artist = cellPresenters[indexPath.row].artist
        getView()?.showAlbums(artist: artist)
    }
    
    func clear() {
        cellPresenters = []
        getView()?.endSearch()
        getView()?.reloadData()
    }
    
}

// MARK: Private

private extension SearchPresenter {
    
    func getView() -> SearchViewProtocol? {
        return view as? SearchViewProtocol
    }
    
}
