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
