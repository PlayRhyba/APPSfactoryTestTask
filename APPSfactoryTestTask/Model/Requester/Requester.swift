//
//  Requester.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 12/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Alamofire
import os.log

final class Requester {
    
    private struct ErrorCodes {
        
        static let canceledOperation = -999
        
    }
    
    private let sessionManager: SessionManager
    private lazy var decoder = JSONDecoder()
    
    // MARK: Initialization
    
    init() {
        sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
    }
    
}

// MARK: RequesterProtocol

extension Requester: RequesterProtocol {
    
    func fetchObject<T: Decodable>(request: Requestable,
                                   completion: @escaping (OperationResult<T, OperationError>) -> Void) {
        sessionManager
            .request(request.baseURL, parameters: request.parameters)
            .validate()
            .responseData { [unowned self] response in
                switch response.result {
                case .success(let data):
                    os_log("DATA RECEIVED: %@", String(data: data, encoding: .utf8) ?? "")
                    
                    do {
                        let object = try self.decoder.decode(T.self, from: data)
                        completion(.success(object))
                    } catch let error {
                        os_log("DECODING ERROR: %@", error.localizedDescription)
                        completion(.failure(.decoding(error.localizedDescription)))
                    }
                    
                case .failure(let error) where (error as NSError).code == ErrorCodes.canceledOperation:
                    os_log("OPERATION HAS BEEN CANCELED")
                    completion(.failure(.canceled))
                    
                case .failure(let error):
                    os_log("NETWORKING ERROR: %@", error.localizedDescription)
                    completion(.failure(.networking(error.localizedDescription)))
                }
        }
    }
    
    func cancel() {
        sessionManager.session.getAllTasks { tasks in
            tasks.forEach { task in task.cancel() }
        }
    }
    
}
