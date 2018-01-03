//
//  ComicsCollectionViewController.swift
//  marvelComics
//
//  Created by Miguel Gomes on 25/12/17.
//  Copyright © 2017 Miguel Gomes. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ComicCell"
private let itemsPerRow: CGFloat = 2
private let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)

class ComicsCollectionViewController: UICollectionViewController {
    
    var comics: [ComicBook] = []
    var comicsCollectionViewModel: ComicsCollectionViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        let apiManager = APIManager()
        comicsCollectionViewModel = ComicsCollectionViewModel(apiManager: apiManager)
        comicsCollectionViewModel?.delegate = self
        
        self.collectionView?.backgroundView = UIImageView(image: UIImage(named: "starsbg"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = comicsCollectionViewModel else {
            return 0
        }
        return viewModel.getComicsCount() + 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ComicCollectionViewCell
        
        if(indexPath.row == comicsCollectionViewModel?.getComicsCount()) {
            //TODO: Load new window
            comicsCollectionViewModel?.loadNewComicsWindow()
            return cell
        }
    
        // Configure the cell
        guard let comic = comicsCollectionViewModel?.getComicAtIndex(index: indexPath.row) else {
            return cell
        }
        cell.setupCell(comic: comic, delegate: comicsCollectionViewModel)
    
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let comic = comicsCollectionViewModel?.getComicAtIndex(index: indexPath.row), let detailVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ComicDetailViewController") as? ComicDetailViewController else {
            return
        }
        detailVc.comic = comic
        let navVC = UINavigationController(rootViewController: detailVc)
        self.present(navVC, animated: true, completion: nil)
        
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension ComicsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableHeight = view.frame.height - CGFloat(paddingSpace)
        let heightPerItem = availableHeight / itemsPerRow
        
        return CGSize(width: heightPerItem * 0.7, height: heightPerItem)
    }
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

// MARK: ComicsCollectionViewModelDelegate

extension ComicsCollectionViewController: ComicsCollectionViewModelDelegate {
    func gotComics() {
        self.collectionView?.reloadData()
    }
}


