//
//  ComicResources.swift
//  marvelComics
//
//  Created by Miguel Gomes on 01/01/18.
//  Copyright © 2018 Miguel Gomes. All rights reserved.
//

import Foundation

struct ComicResources {
    let image: String
}

extension ComicResources {
    init?(json: [String: Any]) {
        guard let images = json["images"] as? [[String: Any]], images.count > 0, let imagePath = images[0]["path"] as? String, let imageExtension = images[0]["extension"] as? String else {
                return nil
        }
        self.image = "\(imagePath).\(imageExtension)"
    }
}
