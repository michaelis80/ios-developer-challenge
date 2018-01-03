//
//  ComicCollectionViewCell.swift
//  marvelComics
//
//  Created by Miguel Gomes on 01/01/18.
//  Copyright © 2018 Miguel Gomes. All rights reserved.
//

import UIKit
import SDWebImage

protocol ComicCollectionViewCellDelegate {
    func gotComicResources(resources: ComicResources)
}

class ComicCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    var delegate:ComicCollectionViewCellDelegate?
}

// MARK: - Custom Methods
extension ComicCollectionViewCell {
    func setupCell(comic: ComicBook, delegate: ComicCollectionViewCellDelegate? = nil) {
        self.imageView.image = nil
        self.backgroundColor = UIColor.lightGray
        
        self.delegate = delegate
        
        if let imageUrl = comic.imageUrl {
            self.imageView?.sd_setImage(with: URL(string: imageUrl))
        } else {
            let apiManager = APIManager()
            apiManager.getComicResources(resourceURI: comic.resourceURI, completion: gotResources)
        }
    }
    
    func gotResources(resources: ComicResources) {
        self.imageView?.sd_setImage(with: URL(string: resources.image))
        delegate?.gotComicResources(resources: resources)
    }
}
