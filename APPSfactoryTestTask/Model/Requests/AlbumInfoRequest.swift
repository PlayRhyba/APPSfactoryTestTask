//
//  AlbumInfoRequest.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 13/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

struct AlbumInfoRequest {
    
    let mbid: String
    
    // MARK: Initialization
    
    init(mbid: String) {
        self.mbid = mbid
    }
    
}

// MARK: Requestable

extension AlbumInfoRequest: Requestable {
    
    var baseURL: String {
        return GlobalConstants.baseURL
    }
    
    var parameters: [String : String] {
        return ["method": "album.getinfo",
                "mbid": mbid,
                "api_key": GlobalConstants.apiKey,
                "format": "json"]
    }
    
}
