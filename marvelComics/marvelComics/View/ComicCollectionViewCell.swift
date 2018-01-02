//
//  ComicCollectionViewCell.swift
//  marvelComics
//
//  Created by Miguel Gomes on 01/01/18.
//  Copyright © 2018 Miguel Gomes. All rights reserved.
//

import UIKit
import SDWebImage

class ComicCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}


// MARK: - Custom Methods
extension ComicCollectionViewCell {
    func setupCell(comic: ComicBook){
        let apiManager = APIManager()
        apiManager.getComicResources(resourceURI: comic.resourceURI, completion: gotResources)
    }
    
    func gotResources(resources: ComicResources) {
        self.imageView?.sd_setImage(with: URL(string: resources.image))
    }
}
