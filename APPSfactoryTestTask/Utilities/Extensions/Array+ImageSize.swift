//
//  Array+ImageSize.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 13/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Foundation

extension Array where Element == Image {
    
    func withSize(_ size: Image.Size) -> URL? {
        return filter { $0.size == size }
            .map { $0.url }
            .first
    }
    
}
