//
//  SearchViewController.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
}

// MARK: SearchViewProtocol

extension SearchViewController: SearchViewProtocol {
    
    func reloadData() {
        
    }
    
}

// MARK: Private

private extension SearchViewController {
    
    func getPresenter() -> SearchPresenterProtocol? {
        return presenter as? SearchPresenterProtocol
    }
    
    func configureAppearance() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_home")!) //!!!
    }
    
}
