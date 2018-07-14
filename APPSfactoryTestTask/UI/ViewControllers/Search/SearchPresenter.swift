//
//  SearchPresenter.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Foundation

final class SearchPresenter: ScreenPresenter {
    
    let apiManager: APIManagerProtocol
    var cellPresenters: [SearchCellPresenterProtocol] = []
    
    // MARK: Initialization
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
    
}

// MARK: SearchPresenterProtocol

extension SearchPresenter: SearchPresenterProtocol {
    
}

// MARK: Private

private extension SearchPresenter {
    
    func getView() -> SearchViewProtocol? {
        return view as? SearchViewProtocol
    }
    
}
