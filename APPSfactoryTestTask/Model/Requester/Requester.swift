//
//  Requester.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 12/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Alamofire

final class Requester {
    
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
                                   completion: @escaping (Response<T, ResponseError>) -> Void) {
        let parameters = request.parameters.merging(["format": "json"],
                                                    uniquingKeysWith: { (first, _) in first })
        sessionManager
            .request(request.baseURL, parameters: parameters)
            .validate()
            .responseData { [unowned self] response in
                switch response.result {
                case .success(let data):
                    do {
                        let object = try self.decoder.decode(T.self, from: data)
                        completion(.success(object))
                    } catch let error {
                        completion(.failure(.decoding(error.localizedDescription)))
                    }
                    
                case .failure(let error):
                    completion(.failure(.alamofire(error.localizedDescription)))
                }
        }
    }
    
    func cancel() {
        sessionManager.session.getAllTasks { tasks in
            tasks.forEach { task in task.cancel() }
        }
    }
    
}
