//
//  AlbumsAssembly.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 15/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Swinject

final class AlbumsAssembly: Assembly {
    
    func assemble(container: Container) {
        container.storyboardInitCompleted(AlbumsViewController.self) { r, vc in
            vc.presenter = r.resolve(AlbumsPresenterProtocol.self)
        }
        
        container.register(AlbumsPresenterProtocol.self) { c in
            let apiManager = c.resolve(APIManagerProtocol.self)!
            let albumStorage = c.resolve(AlbumStorageProtocol.self)!
            
            return AlbumsPresenter(apiManager: apiManager,
                                   albumStorage: albumStorage)
        }
    }
    
}
