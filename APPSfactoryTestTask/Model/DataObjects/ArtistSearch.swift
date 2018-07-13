//
//  ArtistSearch.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 13/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

struct ArtistSearch: Decodable {
    
    struct Artist: Decodable {
        
        let name: String
        let mbid: String?
        let image: [Image]
        
    }
    
    struct ArtistMatches: Decodable {
        
        let artist: [Artist]
        
    }
    
    struct ArtistSearchResult: Decodable {
        
        let artistmatches: ArtistMatches
        
    }
    
    let results: ArtistSearchResult
    
}

extension ArtistSearch {
    
    var artists: [Artist] {
        return results.artistmatches.artist
            .filter { $0.mbid != nil }
    }
    
}
