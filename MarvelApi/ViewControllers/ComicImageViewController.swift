//
//  ComicImageViewController.swift
//  MarvelApi
//
//  Created by lapshop on 12/3/21.
//

import Kingfisher
import UIKit

class ComicImageViewController: UIViewController {
  
    @IBOutlet weak var imageView: UIImageView!
    
    var url : URL?
    var index : Int = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = url else {
            return
        }
        imageView.downloadImage(With: url)
    }

}
