//
//  OperationResult.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 12/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

/// Generic operation result wrapper (do not want to create dependency to Alamofire)
///
/// - success: result with content
/// - failure: failure with error
enum OperationResult<Value, Error: Swift.Error> {
    
    case success(Value)
    case failure(Error)
    
    /// Successfull response
    var isSuccess: Bool {
        switch self {
        case .success:
            return true
            
        case .failure:
            return false
        }
    }
    
    /// Alias for isSuccess negation
    var isFailure: Bool {
        return !isSuccess
    }
    
    /// Attempt to get value
    var value: Value? {
        switch self {
        case .success(let value):
            return value
            
        case .failure:
            return nil
        }
    }
    
}
