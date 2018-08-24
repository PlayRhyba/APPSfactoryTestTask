//
//  DetailsPresentable.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 16/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import RealmSwift

protocol DetailsPresentable {
    
    /// Title
    var albumTitle: String? { get }
    
    /// Artist
    var albumArtist: String? { get }
    
    /// Album id
    var albumMbid: String? { get }
    
    /// Image URL
    var albumImageURL: URL? { get }
    
    /// Tracks
    var albumTracks: [String] { get }
    
}

extension Album: DetailsPresentable {
    
    var albumTitle: String? {
        return title
    }
    
    var albumArtist: String? {
        return artist
    }
    
    var albumMbid: String? {
        return mbid
    }
    
    var albumImageURL: URL? {
        return URL(string: imageURL ?? "")
    }
    
    var albumTracks: [String] {
        return Array(tracks).compactMap { $0.title }
    }
    
}

extension AlbumInfo.Album: DetailsPresentable {
    
    var albumTitle: String? {
        return name
    }
    
    var albumArtist: String? {
        return artist
    }
    
    var albumMbid: String? {
        return mbid
    }
    
    var albumImageURL: URL? {
        let imageURL = [Image.Size.mega,
                        .extralarge,
                        .large,
                        .medium]
            .compactMap { image.imageURL(size: $0) }
            .first
        
        return imageURL
    }
    
    var albumTracks: [String] {
        return trackList.map { $0.name }
            .filter { !$0.isEmpty }
    }
    
}


