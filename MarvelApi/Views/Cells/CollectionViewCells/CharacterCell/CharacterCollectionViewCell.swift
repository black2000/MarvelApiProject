//
//  CharacterCollectionViewCell.swift
//  MarvelApi
//
//  Created by lapshop on 11/15/21.
//

import Foundation
import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func layoutSubviews() {
        self.characterImage.layer.cornerRadius = 10
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.shadowRadius = 10
        self.containerView.layer.shadowColor = UIColor.black.cgColor
        self.containerView.layer.shadowOpacity = 1
        self.containerView.layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    
    func configure(with character:MarvelCharacter) {
        characterNameLabel.text = character.name
        if let imageUrl = EndPoint.getSizedMarvelCharacterImage(path: character.thumbnail.path, extension: character.thumbnail.fileExtension, imageSize: .portraitXlarge).url {
            characterImage.downloadImage(With: imageUrl)
        }
        
       
    }
    
}
