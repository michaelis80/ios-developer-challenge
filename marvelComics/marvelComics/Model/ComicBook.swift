//
//  ComicBook.swift
//  marvelComics
//
//  Created by Miguel Gomes on 27/12/17.
//  Copyright © 2017 Miguel Gomes. All rights reserved.
//

import Foundation

struct ComicBook {
    let id: Int
    let title: String
    let description: String
    let resourceURI: String
    var imageUrl: String?
}

extension ComicBook {
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let description = json["description"] as? String,
            let resourceURI = json["resourceURI"] as? String
            else {
                return nil
        }
        
        self.id = id
        self.title = title
        self.description = description
        self.resourceURI = resourceURI
    }
}

