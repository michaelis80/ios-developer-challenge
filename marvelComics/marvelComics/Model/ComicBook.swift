//
//  ComicBook.swift
//  marvelComics
//
//  Created by Miguel Gomes on 27/12/17.
//  Copyright © 2017 Miguel Gomes. All rights reserved.
//

import Foundation

struct ComicBook {
    let title: String
    let description: String
    let resourceURI: String
}

extension ComicBook {
    init?(json: [String: Any]) {
        guard let title = json["title"] as? String,
            let description = json["description"] as? String,
            let resourceURI = json["resourceURI"] as? String
            else {
                return nil
        }
        
        self.title = title
        self.description = description
        self.resourceURI = resourceURI
    }
}

