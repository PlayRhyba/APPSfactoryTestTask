//
//  Artist.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 12/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

struct Artist: Decodable {
    
    let name: String
    let mbid: String
    let image: [Image]
    
}
