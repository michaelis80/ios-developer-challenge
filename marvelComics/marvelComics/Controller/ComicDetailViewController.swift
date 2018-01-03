//
//  ComicDetailViewController.swift
//  marvelComics
//
//  Created by Miguel Gomes on 03/01/18.
//  Copyright © 2018 Miguel Gomes. All rights reserved.
//

import UIKit

// TODO: Scroll, favorite button, improve layout

class ComicDetailViewController: UIViewController {

    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var comic: ComicBook?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let comicImageUrl = comic?.imageUrl else {
            return
        }
        comicImageView.sd_setImage(with: URL(string: comicImageUrl))
        titleLabel.text = comic?.title
        descriptionLabel.text = comic?.description
        
        
        let letfBarButton = UIBarButtonItem(title: "Home", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ComicDetailViewController.homeAction(_:)))
        self.navigationItem.leftBarButtonItem = letfBarButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Selector
    
    @objc func homeAction(_ sender:UIBarButtonItem!) {
        self.dismiss(animated: true, completion: nil)
    }
}
