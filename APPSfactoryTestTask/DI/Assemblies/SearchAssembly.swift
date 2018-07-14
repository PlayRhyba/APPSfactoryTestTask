//
//  SearchAssembly.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Swinject

final class SearchAssembly: Assembly {
    
    func assemble(container: Container) {
        container.storyboardInitCompleted(SearchViewController.self) { r, vc in
            vc.presenter = r.resolve(SearchPresenterProtocol.self)
        }
        
        container.register(SearchPresenterProtocol.self) { c in
            let apiManager = c.resolve(APIManagerProtocol.self)!
            
            return SearchPresenter(apiManager: apiManager)
        }
    }
    
}
