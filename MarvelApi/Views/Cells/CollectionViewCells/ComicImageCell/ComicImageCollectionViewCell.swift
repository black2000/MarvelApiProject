//
//  ComicImageCollectionViewCell.swift
//  MarvelApi
//
//  Created by lapshop on 12/4/21.
//

import UIKit

class ComicImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var comicImageView: UIImageView!
    
  
    func configureCell(wuth comic:Comic) {
        if let imageUrl = EndPoint.getSizedMarvelCharacterImage(path: comic.thumbnail.path, extension: comic.thumbnail.fileExtension, imageSize: .portraitXlarge).url {
            comicImageView.downloadImage(With: imageUrl)
        }
    }
    
}
