//
//  HomeAssembly.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Swinject

final class HomeAssembly: Assembly {
    
    func assemble(container: Container) {
        container.storyboardInitCompleted(HomeViewController.self) { r, vc in
            vc.albumStorage = r.resolve(AlbumStorageProtocol.self)
        }
    }
    
}
