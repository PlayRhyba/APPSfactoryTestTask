//
//  NSPredicate+Search.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 15/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Foundation

extension NSPredicate {
    
    static func mbidBasedSearchPredicate(mbid: String) -> NSPredicate {
        return NSPredicate(format: "mbid ==[c] %@", mbid)
    }
    
}
