//
//  TopAlbums.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 13/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

struct TopAlbums: Decodable {
    
    struct Album: Decodable {
        
        struct Artist: Decodable {
            
            let name: String
            
        }
        
        let name: String
        let mbid: String?
        let artist: Artist
        let image: [Image]?
        
    }
    
    struct TopAlbums: Decodable {
        
        let album: [Album]
        
    }
    
    let topalbums: TopAlbums
    
}

extension TopAlbums {
    
    var albums: [Album] {
        return topalbums.album
            .filter { $0.mbid?.isEmpty == false }
            .sorted { $0.name < $1.name }
    }
    
}
