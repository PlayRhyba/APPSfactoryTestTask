//
//  ArtistSearchResponse.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 13/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

struct ArtistSearchResponse: Decodable {
    
    struct ArtistMatches: Decodable {
        
        let artist: [Artist]
        
    }
    
    struct ArtistSearchResult: Decodable {
        
        let artistmatches: ArtistMatches
        
    }
    
    let results: ArtistSearchResult
    
}

extension ArtistSearchResponse {
    
    var artists: [Artist] {
        return results.artistmatches.artist
    }
    
}
