//
//  Album.swift
//  APPSfactoryTestTask
//
//  Created by Alexander Snegursky on 23/08/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import RealmSwift

final class Album: Object {
    
    @objc dynamic var artist: String? = nil
    @objc dynamic var imageURL: String? = nil
    @objc dynamic var mbid: String? = nil
    @objc dynamic var title: String? = nil
    var tracks = List<Track>()
    
}
