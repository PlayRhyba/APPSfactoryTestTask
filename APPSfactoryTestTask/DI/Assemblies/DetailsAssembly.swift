//
//  DetailsAssembly.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 16/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Swinject

final class DetailsAssembly: Assembly {
    
    func assemble(container: Container) {
        container.storyboardInitCompleted(DetailsViewController.self) { r, vc in
            vc.presenter = r.resolve(DetailsPresenterProtocol.self)
        }
        
        container.register(DetailsPresenterProtocol.self) { c in
            let albumStorage = c.resolve(AlbumStorageProtocol.self)!
            
            return DetailsPresenter(albumStorage: albumStorage)
        }
    }
    
}
