//
//  AlbumStorage.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 13/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import CoreData

final class AlbumStorage {
    
    private let persistentContainer: NSPersistentContainer
    
    // MARK: Initialization
    
    init() {
        persistentContainer = NSPersistentContainer(name: GlobalConstants.dataModelName)
    }
    
}

// MARK: Setup

extension AlbumStorage {
    
    func setup(completion: @escaping (OperationResult<Void, OperationError>) -> Void) {
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                completion(.failure(.database(error.localizedDescription)))
            } else {
                completion(.success(()))
            }
        }
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
    
    func fetchAlbums(sortDescriptor: NSSortDescriptor,
                     completion: @escaping (OperationResult<[Album], OperationError>) -> Void) {
        Album.asyncFetch(configuration: { request in request.sortDescriptors = [sortDescriptor] },
                         in: persistentContainer.viewContext,
                         completion: completion)
    }
    
    func add(album: AlbumInfo.Album,
             completion: @escaping (OperationResult<Album, OperationError>) -> Void) {
        persistentContainer.performBackgroundTask { context in
            let storedAlbum = Album(context: context)
            storedAlbum.mbid = album.mbid
            storedAlbum.title = album.name
            storedAlbum.artist = album.artist
            
            let imageURL = [Image.Size.mega,
                            .extralarge,
                            .large,
                            .medium]
                .compactMap { album.image.imageURL(size: $0) }
                .first
            
            storedAlbum.imageURL = imageURL?.absoluteString
            
            album.trackList.forEach { track in
                let storedTrack = Track(context: context)
                storedTrack.title = track.name
                
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
            Album.asyncFetch(configuration: { request in request.predicate = NSPredicate(format: "mbid ==[c] %@", albumId) },
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
