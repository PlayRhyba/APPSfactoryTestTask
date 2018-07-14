//
//  StorageAssembly.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Swinject

final class StorageAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AlbumStorageProtocol.self) { _ in AlbumStorage.shared }
    }
    
}
