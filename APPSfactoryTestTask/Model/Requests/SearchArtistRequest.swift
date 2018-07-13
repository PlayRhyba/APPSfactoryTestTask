//
//  SearchArtistRequest.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 13/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

struct SearchArtistRequest {
    
    let name: String
    
    // MARK: Initialization
    
    init(name: String) {
        self.name = name
    }
    
}

// MARK: Requestable

extension SearchArtistRequest: Requestable {
    
    var baseURL: String {
        return GlobalConstants.baseURL
    }
    
    var parameters: [String : String] {
        return ["method": "artist.search",
                "artist": name.lowercased(),
                "api_key": GlobalConstants.apiKey]
    }
    
    
    
}
