//
//  AlbumInfo.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 13/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

struct AlbumInfo: Decodable {
    
    struct Album: Decodable {
        
        struct Track: Decodable {
            
            let name: String
            
        }
        
        struct Tracks: Decodable {
            
            let track: [Track]
            
        }
        
        let mbid: String
        let name: String
        let artist: String
        let image: [Image]
        let tracks: Tracks
        
    }
    
    let album: Album
    
}

extension AlbumInfo.Album {
    
    var trackList: [Track] {
        return tracks.track
    }
    
}
