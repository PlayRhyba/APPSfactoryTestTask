//
//  View.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

protocol ViewProtocol: class {
    
    /// Identifier
    var identifier: String { get }
    
}

extension ViewProtocol {
    
    var identifier: String {
        return String(describing: type(of: self))
    }
    
}
