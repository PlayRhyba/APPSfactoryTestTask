//
//  Requestable.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 12/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

/// Request representation
protocol Requestable {
    
    /// Base URL
    var baseURL: String { get }
    
    /// Parameters
    var parameters: [String: String] { get }
    
}


