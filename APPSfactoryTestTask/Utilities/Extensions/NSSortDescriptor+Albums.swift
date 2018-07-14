//
//  NSSortDescriptor+Albums.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Foundation

extension NSSortDescriptor {
    
    static var albumsSortDescriptor: NSSortDescriptor {
        return NSSortDescriptor(key: #keyPath(Album.title), ascending: true)
    }
    
}
