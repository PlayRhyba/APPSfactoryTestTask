//
//  AlbumStorage.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 13/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import RealmSwift

final class AlbumStorage {
    
    static let shared = AlbumStorage()
    
}

// MARK: For unit testing

#if DEBUG

extension AlbumStorage {
    
    func clear() {
        guard let realm = try? Realm() else { return }
        
        try? realm.write {
            realm.deleteAll()
        }
    }
    
}

#endif

// MARK: AlbumStorageProtocol

extension AlbumStorage: AlbumStorageProtocol {
    
    func load(completion: @escaping (OperationResult<Void, OperationError>) -> Void) {}
    
    func fetchAlbums(sortDescriptor: NSSortDescriptor,
                     completion: @escaping (OperationResult<[Album], OperationError>) -> Void) {
        do {
            let realm = try Realm()
            let result = realm.objects(Album.self)
            
            completion(.success(Array(result)))
        } catch {
            completion(.failure(.database(error.localizedDescription)))
        }
    }
    
    func add(album: DetailsPresentable,
             completion: @escaping (OperationResult<Album, OperationError>) -> Void) {
        do {
            let realm = try Realm()
            
            let storedAlbum = Album()
            storedAlbum.mbid = album.albumMbid
            storedAlbum.title = album.albumTitle
            storedAlbum.artist = album.albumArtist
            storedAlbum.imageURL = album.albumImageURL?.absoluteString
            
            album.albumTracks.forEach { track in
                let storedTrack = Track()
                storedTrack.title = track
                
                storedAlbum.tracks.append(storedTrack)
            }
            
            try realm.write {
                realm.add(storedAlbum)
            }
            
            completion(.success(storedAlbum))
        } catch {
            completion(.failure(.database(error.localizedDescription)))
        }
    }
    
    func remove(albumId: String,
                completion: @escaping (OperationResult<Void, OperationError>) -> Void) {
        do {
            let realm = try Realm()
            
            guard let album = realm.objects(Album.self)
                .filter(NSPredicate.mbidBasedSearchPredicate(mbid: albumId))
                .first else {
                    completion(.failure(.database("Object not found")))
                    
                    return
            }
            
            try realm.write {
                realm.delete(album)
            }
            
            completion(.success(()))
            
        } catch {
            completion(.failure(.database(error.localizedDescription)))
        }
    }
    
}
