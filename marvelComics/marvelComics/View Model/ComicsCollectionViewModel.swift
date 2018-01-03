//
//  ComicsCollectionViewModel.swift
//  marvelComics
//
//  Created by Miguel Gomes on 03/01/18.
//  Copyright © 2018 Miguel Gomes. All rights reserved.
//

import Foundation

private let offsetIncrement = 20

protocol ComicsCollectionViewModelDelegate {
    func gotComics()
}

class ComicsCollectionViewModel {
    
    private let apiManager: APIManager
    private var comics: [ComicBook]
    var delegate:ComicsCollectionViewModelDelegate?
    var currentOffset = 0
    
    init(apiManager: APIManager) {
        comics = []
        self.apiManager = apiManager
        loadComics(offset: 0)
    }
    
    func gotComics(comics:[ComicBook]){
        self.comics += comics
        delegate?.gotComics()
    }
    
    func getComicsCount() -> Int {
        return self.comics.count
    }
    
    func getComicAtIndex(index: Int) -> ComicBook? {
        guard comics.count > index else {
            return nil
        }
        return self.comics[index]
    }
    
    func loadComics(offset: Int) {
        self.currentOffset = offset
        self.apiManager.getComicBooks(offset: offset, completion: gotComics)
    }
    
    func loadNewComicsWindow() {
        self.currentOffset += offsetIncrement
        self.loadComics(offset: self.currentOffset)
    }
}

extension ComicsCollectionViewModel: ComicCollectionViewCellDelegate {
    func gotComicResources(resources: ComicResources) {
        for index in 0...comics.count - 1 {
            if comics[index].id == resources.id {
                comics[index].imageUrl = resources.image
            }
        }
    }
}
