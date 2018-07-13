//
//  APIManagerProtocol.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 12/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

protocol APIManagerProtocol {
    
    /// Search artist by name
    ///
    /// - Parameters:
    ///   - name: artist's name
    ///   - completion: completion handler with collection of found artists' info
    func searchArtist(name: String,
                      completion: @escaping (Response<[Artist], ResponseError>) -> Void)
    
}
