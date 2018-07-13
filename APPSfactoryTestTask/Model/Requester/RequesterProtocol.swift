//
//  RequesterProtocol.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 12/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

protocol RequesterProtocol {
    
    /// Fetch object
    ///
    /// - Parameters:
    ///   - request: request representation
    ///   - completion: completion handler
    func fetchObject<T: Decodable>(request: Requestable,
                                   completion: @escaping (OperationResult<T, OperationError>) -> Void)
    
    /// Cancel all operations
    func cancel()
    
}
