//
//  DependencyManager.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Swinject
import SwinjectStoryboard

final class DependencyManager {
    
    static func makeContainer() -> Container {
        let container = SwinjectStoryboard.defaultContainer
        
        let assemblies: [Assembly] = [StorageAssembly(),
                                      NetworkingAssembly(),
                                      HomeAssembly(),
                                      SearchAssembly(),
                                      AlbumsAssembly(),
                                      DetailsAssembly()]
        
        _ = Assembler(assemblies, container: container)
        
        return container
    }
    
}

