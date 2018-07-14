//
//  Sequence+ImageSize.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 13/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element == Image {
    
    func imageURL(size: Image.Size) -> URL? {
        return filter { $0.size == size }
            .compactMap { URL(string: $0.url) }
            .first
    }
    
}
