//
//  AlbumStorage.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 13/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import CoreData

final class AlbumStorage {
    
    static let shared = AlbumStorage()
    private let persistentContainer: NSPersistentContainer
    
    // MARK: Initialization
    
    private init() {
        persistentContainer = NSPersistentContainer(name: GlobalConstants.dataModelName)
    }
    
}

// MARK: For unit testing

#if DEBUG

extension AlbumStorage {
    
    func clear() {
        let context = persistentContainer.viewContext
        try? Album.deleteAll(inContext: context)
        save()
    }
    
    private func save() {
        if persistentContainer.viewContext.hasChanges {
            try? persistentContainer.viewContext.save()
        }
    }
    
}

#endif

// MARK: AlbumStorageProtocol

extension AlbumStorage: AlbumStorageProtocol {
    
    func load(completion: @escaping (OperationResult<Void, OperationError>) -> Void) {
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                completion(.failure(.database(error.localizedDescription)))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchAlbums(sortDescriptor: NSSortDescriptor,
                     completion: @escaping (OperationResult<[Album], OperationError>) -> Void) {
        Album.asyncFetch(configuration: { request in request.sortDescriptors = [sortDescriptor] },
                         in: persistentContainer.viewContext,
                         completion: completion)
    }
    
    func add(album: DetailsPresentable,
             completion: @escaping (OperationResult<Album, OperationError>) -> Void) {
        persistentContainer.performBackgroundTask { context in
            let storedAlbum = Album(context: context)
            storedAlbum.mbid = album.albumMbid
            storedAlbum.title = album.albumTitle
            storedAlbum.artist = album.albumArtist
            storedAlbum.imageURL = album.albumImageURL?.absoluteString
            
            album.albumTracks.forEach { track in
                let storedTrack = Track(context: context)
                storedTrack.title = track
                
                storedAlbum.addToTracks(storedTrack)
            }
            
            do {
                try context.save()
                completion(.success(storedAlbum))
            } catch {
                completion(.failure(.database(error.localizedDescription)))
            }
        }
    }
    
    func remove(albumId: String,
                completion: @escaping (OperationResult<Void, OperationError>) -> Void) {
        persistentContainer.performBackgroundTask { context in
            Album.asyncFetch(configuration: { request in request.predicate = NSPredicate.mbidBasedSearchPredicate(mbid: albumId) },
                             in: context,
                             completion: { (result: OperationResult<[Album], OperationError>) in
                                switch result {
                                case .success(let albums):
                                    guard let album = albums.first else {
                                        completion(.failure(.database("Object not found")))
                                        
                                        break
                                    }
                                    
                                    context.delete(album)
                                    
                                    do {
                                        try context.save()
                                        completion(.success(()))
                                    } catch {
                                        completion(.failure(.database(error.localizedDescription)))
                                    }
                                    
                                case .failure(let error):
                                    completion(.failure(error))
                                }
            })
        }
    }
    
}
