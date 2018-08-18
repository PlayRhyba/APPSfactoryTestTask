//
//  NetworkingAssembly.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Swinject

final class NetworkingAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(RequesterProtocol.self) { _ in Requester() }
            .inObjectScope(.container)
        
        container.register(APIManagerProtocol.self) { c in
            let requester = c.resolve(RequesterProtocol.self)!
            
            return APIManager(requester: requester)
            }.inObjectScope(.container)
    }
    
}
