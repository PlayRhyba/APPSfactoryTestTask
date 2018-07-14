//
//  NSManagedObject+Extensions.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 13/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import CoreData

extension NSManagedObject {
    
    class func asyncFetch<T: NSManagedObject>(configuration:(((NSFetchRequest<T>) -> Void)?),
                                              in context: NSManagedObjectContext,
                                              completion: @escaping (OperationResult<[T], OperationError>) -> Void) {
        guard let fetchRequest = fetchRequest() as? NSFetchRequest<T> else {
            completion(.failure(.database("Internal error")))
            
            return
        }
        
        configuration?(fetchRequest)
        
        let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { result in
            if let error = result.operationError {
                completion(.failure(.database(error.localizedDescription)))
            } else {
                completion(.success(result.finalResult ?? []))
            }
        }
        
        _ = try? context.execute(asyncFetchRequest)
    }
    
    class func deleteAll(inContext context: NSManagedObjectContext) throws {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest())
        try context.persistentStoreCoordinator?.execute(deleteRequest, with: context)
    }
    
}
