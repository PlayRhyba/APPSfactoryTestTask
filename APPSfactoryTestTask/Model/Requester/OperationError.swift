//
//  OperationError.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 12/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

/// Error representation
///
/// - decoding: decoding error
/// - alamofire: alamofire error
/// - database: database error
//  - canceled: operation was canceled
enum OperationError: Error {
    
    case decoding(String)
    case networking(String)
    case database(String)
    case canceled
    
}

extension OperationError {
    
    /// Message to display
    var message: String? {
        switch self {
        case .decoding(let text):
            return text
            
        case .networking(let text):
            return text
            
        case .database(let text):
            return text
            
        default:
            return localizedDescription
        }
    }
    
}
