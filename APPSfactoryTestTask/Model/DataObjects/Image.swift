//
//  Image.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 13/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Foundation

struct Image: Codable {
    
    enum Size: String, Codable {
        
        case small
        case medium
        case large
        case extralarge
        case mega
        case unknown = ""
        
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case url = "#text"
        case size
        
    }
    
    let url: String
    let size: Size
    
}
